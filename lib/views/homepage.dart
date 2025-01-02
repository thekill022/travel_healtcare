import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/content_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: const Text(
                  " Welcome to \n Travel Healthcare",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: const Text(
                  "The Travel Healthcare application provides informative pre- and post-travel features. Users can select a country,province and cities and get information about five health diseases typical of each province.",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 78, 76, 76)),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
