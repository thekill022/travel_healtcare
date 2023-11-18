import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header.dart';
import 'package:travel_healthcare/views/homepage.dart';
import 'package:travel_healthcare/views/post_travel.dart';
import 'package:travel_healthcare/views/pra_travel.dart';
import 'package:travel_healthcare/views/riwayat_perjalanan.dart';

class HomeNavbarPage extends StatefulWidget {
  const HomeNavbarPage({super.key});

  @override
  State<HomeNavbarPage> createState() => _HomeNavbarPageState();
}

class _HomeNavbarPageState extends State<HomeNavbarPage> {
  final List<Map<String, dynamic>> pageDetails = [
    {'pageName': PredictPage(), 'title': 'Predict'},
    {'pagename': PostTravelPage(), 'title': 'Diagnostics'},
    {'pagename': RiwayatPerjalanan(), 'title': 'Riwayat'},
    {'pagename': HomePage(), 'title': 'Home'},
  ];

  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, titleText: "Travel Healthcare"),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.online_prediction_outlined), label: 'Predict'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_to_queue_outlined), label: 'Diagnostics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
          ]),
    );
  }
}
