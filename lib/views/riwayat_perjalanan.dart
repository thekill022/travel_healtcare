import 'package:flutter/material.dart';
import 'package:travel_healthcare/views/perjalanan/form_perjalanan.dart';

class RiwayatPerjalanan extends StatefulWidget {
  const RiwayatPerjalanan({super.key});

  @override
  State<RiwayatPerjalanan> createState() => _RiwayatPerjalananState();
}

class _RiwayatPerjalananState extends State<RiwayatPerjalanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Halaman Riwayat Perjalanan'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormPerjalanan()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
