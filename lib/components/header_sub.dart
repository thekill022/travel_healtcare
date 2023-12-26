import 'package:flutter/material.dart';

AppBar HeaderSub(context, {bool isTitle = false, required String titleText}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isTitle ? "Travel Healthcare" : titleText,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 81, 134, 177),
    automaticallyImplyLeading: true,
  );
}
