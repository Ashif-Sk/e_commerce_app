import 'package:flutter/material.dart';

class BigOutlineButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final IconData icon;
  const BigOutlineButton({super.key, required this.onPressed, required this.buttonText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.066,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
         side: BorderSide(color: Theme.of(context).colorScheme.secondary,width: 2)
        ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,size: 35,),
              Text(
                buttonText,
                style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary
                ) ,),
            ],
          ),),
    );
  }
}
