import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
  int currentPage = 0;

  List<Widget> pages = const [
    HomePage(),
    PredictPage(),
    PostTravelPage(),
    RiwayatPerjalanan()
  ];
  // final List<Map<String, dynamic>> pageDetails = [
  //   {'pageName': const PredictPage(), 'title': 'Predict'},
  //   {'pagename': const PostTravelPage(), 'title': 'Diagnostics'},
  //   {'pagename': const RiwayatPerjalanan(), 'title': 'Riwayat'},
  //   {'pagename': const HomePage(), 'title': 'Home'},
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, titleText: "Travel Healthcare"),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Beranda'),
          NavigationDestination(
              icon: Icon(Iconsax.shield_search), label: 'Pantau Penyakit'),
          NavigationDestination(
              icon: Icon(Iconsax.element_plus), label: 'Diagnosis'),
          NavigationDestination(
              icon: Icon(Iconsax.clipboard_text), label: 'Riwayat')
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
