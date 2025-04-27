import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:order_app/Pages/Order%20Pages/order_confirmed_page.dart';
// import 'package:upi_india/upi_india.dart';

import '../../Components/ui_components.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  UiComponents uiComponents = UiComponents();
  // UpiIndia upiIndia =UpiIndia();
  // Future<UpiResponse>? _transaction;
  // List<UpiApp>? apps;

  final GlobalKey<FormState> _globalKey = GlobalKey();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String? _upiAddrError;

  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isUpiEditable = false;
  List<ApplicationMeta>? _apps;

  @override
  void initState() {
    // upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value){
    //   setState(() {
    //     apps = value;
    //   });
    // }).catchError((e){
    //   apps=[];
    // });
    super.initState();
    _upiAddressController.text = "skashifmostafa94@oksbi";
    _amountController.text =
        (Random.secure().nextDouble() * 10).toStringAsFixed(2);

    Future.delayed(const Duration(milliseconds: 0), () async {
      _apps = await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
      setState(() {});
    });

  }
  @override
  void dispose() {
    _amountController.dispose();
    _upiAddressController.dispose();
    super.dispose();
  }

  void _generateAmount() {
    setState(() {
      _amountController.text =
          (Random.secure().nextDouble() * 10).toStringAsFixed(2);
    });
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final err = _validateUpiAddress(_upiAddressController.text);
    if (err != null) {
      setState(() {
        _upiAddrError = err;
      });
      return;
    }
    setState(() {
      _upiAddrError = null;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    if (kDebugMode) {
      print("Starting transaction with id $transactionRef");
    }

    final a = await UpiPay.initiateTransaction(
      amount: _amountController.text,
      app: app.upiApplication,
      receiverName: 'Sharad',
      receiverUpiAddress: _upiAddressController.text,
      transactionRef: transactionRef,
      transactionNote: 'UPI Payment',
      // merchantCode: '7372',
    );
  }
  String? _validateUpiAddress(String value) {
    if (value.isEmpty) {
      return 'UPI VPA is required.';
    }
    if (value.split('@').length != 2) {
      return 'Invalid UPI VPA';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: uiComponents.appBarText(context, 'Payment'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            //true when you want to show cvv(back) view
            onCreditCardWidgetChange: (CreditCardBrand
                brand) {}, // Callback for anytime credit card brand is changed
          ),
          CreditCardForm(
              formKey: _globalKey,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              obscureCvv: true,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              inputConfiguration: InputConfiguration(
                cardNumberDecoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Card Holder',
                  hintText: 'e.g. Jhon Doe',
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Center(
            child:uiComponents.normalText(context, '- - - - Or - - - -'),
          ),
          const SizedBox(
            height: 10,
          ),
          // Center(
          //   child: Wrap(
          //     children: apps!.map<Widget>((UpiApp app){
          //       return GestureDetector(
          //         onTap: () {
          //           _transaction = initiateTransaction(app);
          //           setState(() {});
          //         },
          //         child: SizedBox(
          //           height: 100,
          //           width: 100,
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               Image.memory(
          //                 app.icon,
          //                 height: 60,
          //                 width: 60,
          //               ),
          //               Text(app.name),
          //             ],
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                _vpa(),
                if (_upiAddrError != null) _vpaError(),
                _amount(),
                if (Platform.isIOS) _submitButton(),
                Platform.isAndroid ? _androidApps() : _iosApps(),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: UniversalButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderConfirmedPage())),
                buttonText: 'Confirm'),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  // Future<UpiResponse>? initiateTransaction(UpiApp app) {
  //   return upiIndia.startTransaction(
  //       app: app,
  //       receiverUpiId: 'skashifmostafa94@oksbi',
  //       receiverName: 'Fresh Product',
  //       transactionRefId: 'transactionRefId',
  //       amount: 20,
  //       transactionNote: 'Pay to Fresh Product'
  //   );
  // }
  Widget _vpa() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _upiAddressController,
              enabled: _isUpiEditable,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'address@upi',
                labelText: 'Receiving UPI Address',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(
                _isUpiEditable ? Icons.check : Icons.edit,
              ),
              onPressed: () {
                setState(() {
                  _isUpiEditable = !_isUpiEditable;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vpaError() {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 12),
      child: Text(
        _upiAddrError!,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _amount() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _amountController,
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(Icons.loop),
              onPressed: _generateAmount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              onPressed: () async => await _onTap(_apps![0]),
              color: Theme.of(context).colorScheme.secondary,
              height: 48,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Text('Initiate Transaction',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _androidApps() {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              'Pay Using',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          if (_apps != null) _appsGrid(_apps!.map((e) => e).toList()),
        ],
      ),
    );
  }

  Widget _iosApps() {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 24),
            child: Text(
              'One of these will be invoked automatically by your phone to '
                  'make a payment',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              'Detected Installed Apps',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          if (_apps != null) _discoverableAppsGrid(),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              'Other Supported Apps (Cannot detect)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          if (_apps != null) _nonDiscoverableAppsGrid(),
        ],
      ),
    );
  }

  GridView _discoverableAppsGrid() {
    List<ApplicationMeta> metaList = [];
    for (var e in _apps!) {
      if (e.upiApplication.discoveryCustomScheme != null) {
        metaList.add(e);
      }
    }
    return _appsGrid(metaList);
  }

  GridView _nonDiscoverableAppsGrid() {
    List<ApplicationMeta> metaList = [];
    for (var e in _apps!) {
      if (e.upiApplication.discoveryCustomScheme == null) {
        metaList.add(e);
      }
    }
    return _appsGrid(metaList);
  }

  GridView _appsGrid(List<ApplicationMeta> apps) {
    apps.sort((a, b) => a.upiApplication
        .getAppName()
        .toLowerCase()
        .compareTo(b.upiApplication.getAppName().toLowerCase()));
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      // childAspectRatio: 1.6,
      physics: NeverScrollableScrollPhysics(),
      children: apps
          .map(
            (it) => Material(
          key: ObjectKey(it.upiApplication),
          // color: Colors.grey[200],
          child: InkWell(
            onTap: Platform.isAndroid ? () async => await _onTap(it) : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                it.iconImage(48),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  alignment: Alignment.center,
                  child: Text(
                    it.upiApplication.getAppName(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          .toList(),
    );
  }

}

