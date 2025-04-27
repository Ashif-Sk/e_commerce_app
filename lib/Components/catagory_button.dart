import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Color color;
  final Color imageColor;
  final String image;
  final String text;
  final void Function()? onTap;

  const CategoryButton(
      {super.key,
      required this.color,
      required this.image,
      required this.text,
      required this.imageColor,required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.1,
        width: width * 0.18,
        decoration:
            BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: Color(0xFF5359DC))
            ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                width: 40,
                child: Image.asset(
                  image,
                  color: imageColor,
                  fit: BoxFit.fill,
                ),
              ),
              Text(text,style: TextStyle(color: Colors.black,))
            ],
          ),
        ),
      ),
    );
  }
}
