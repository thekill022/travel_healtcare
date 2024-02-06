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
              Container(
                child: KontenSection(context, imgUrl: "images/konten.png"),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: const Text(
                  " Selamat Datang di \n Travel Healthcare",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: const Text(
                  "Aplikasi Travel Healthcare menyediakan fitur pra dan post travel yang informatif. Pengguna dapat memilih provinsi di Indonesia dan mendapatkan informasi tentang lima penyakit kesehatan khas setiap provinsi.",
                  style: TextStyle(fontSize: 14, color: Colors.black),
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
