import 'package:flutter/material.dart';
import 'package:travel_healthcare/views/profile.dart';

AppBar Header(context, {bool isTitle = false, required String titleText}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isTitle ? "Travel Healthcare" : titleText,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        )
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 81, 134, 177),
    automaticallyImplyLeading: false,
  );
}
