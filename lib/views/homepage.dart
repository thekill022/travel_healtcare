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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: KontenSection(context, imgUrl: "images/konten.png"),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Travel Healthcare",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Aplikasi Travel Healthcare menyediakan fitur pra dan post travel yang informatif. Pengguna dapat memilih provinsi di Indonesia dan mendapatkan informasi tentang lima penyakit kesehatan khas setiap provinsi. Fitur post travel memberikan informasi gejala dan panduan mendiagnosis lima penyakit tersebut. Tujuannya adalah memberikan pemahaman kesehatan sebelum dan setelah perjalanan, mendukung pencegahan penyakit, dan memberikan bantuan cepat saat gejala muncul pasca perjalanan.",
                style: TextStyle(fontSize: 14, color: Colors.blue[800]),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
