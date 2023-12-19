import 'package:flutter/material.dart';

Container KontenSection(context, {String? imgUrl}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.pink,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(imgUrl!),
      ),
    ),
  );
}
