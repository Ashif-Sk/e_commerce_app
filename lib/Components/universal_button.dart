import 'package:flutter/material.dart';

class UniversalButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
   const UniversalButton({super.key,required this.onPressed , required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.066,
      child: ElevatedButton(
          onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary
        ),
          child:Text(
            buttonText,
            style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.tertiary
            ) ,),
      ),
    );
  }
}
