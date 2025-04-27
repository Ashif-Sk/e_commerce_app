import 'package:flutter/material.dart';

class ReusableListile extends StatelessWidget {
  final String text;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final void Function()? onTap;
  const ReusableListile({super.key, required this.text, required this.leadingIcon, required this.onTap, required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          onTap: onTap,
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          leading: Icon(leadingIcon,color: Colors.orangeAccent,),
          title: Text(text),
          trailing: Icon(trailingIcon,size: 35,),
        ),
       const SizedBox(height: 8,)
      ],
    );
  }
}
