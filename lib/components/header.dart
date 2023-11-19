import 'package:flutter/material.dart';

AppBar Header(context, {bool isTitle = false, required String titleText}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isTitle ? "Travel Healthcare" : titleText,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        )
      ],
    ),
    backgroundColor: Colors.lightBlueAccent,
    automaticallyImplyLeading: false,
  );
}
