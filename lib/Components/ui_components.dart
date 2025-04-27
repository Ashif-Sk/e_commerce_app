import 'package:flutter/material.dart';

class UiComponents {

  Text titleText (BuildContext context,String text){
    return Text(
      text,
      style:  TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.tertiary,
        letterSpacing: 2,
          wordSpacing: 4,
        fontStyle: FontStyle.italic
      ) ,);
  }

  Text appBarText (BuildContext context,String text){
    return Text(
      text,
      style:  TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.tertiary
      ) ,);
  }
  Text h1Text (BuildContext context,String text){
    return Text(
      text,
      style:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.tertiary
      ) ,);
  }

  Text normalText (BuildContext context,String text){
    return Text(
      text,
      style:  TextStyle(
        overflow: TextOverflow.visible,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.tertiary
      ) ,);
  }

  Row textRow (BuildContext context,String text,String priceText){
    return Row(
      children: [
      Text(
      text,
      style:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.tertiary
      ) ,),
        const Spacer(),
        Text(
          priceText,
          style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary
          ) ,),
      ],
    );
  }
}