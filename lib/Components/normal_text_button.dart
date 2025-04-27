import 'package:flutter/material.dart';

class NormalTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final String extraText;
  const NormalTextButton({super.key,required this.onPressed, required this.buttonText, required this.extraText});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(extraText),
        TextButton(
          onPressed: onPressed,
          child:  Text(
            buttonText,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15),
          ),
        ),
      ],
    );
  }
}
