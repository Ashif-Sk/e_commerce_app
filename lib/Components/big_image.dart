import 'package:flutter/material.dart';

class BigImage extends StatelessWidget {
  final String imagePath;
  const BigImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.25,
      width: width * 05,
      child:  Image(image: AssetImage(imagePath)),
    );
  }
}
