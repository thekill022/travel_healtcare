import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/components/header.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/views/homepage.dart';
import 'package:travel_healthcare/views/login.dart';
import 'package:travel_healthcare/views/post_travel.dart';
import 'package:travel_healthcare/views/pra_travel.dart';
import 'package:travel_healthcare/views/riwayat_perjalanan.dart';

class HomeNavbarPage extends StatefulWidget {
  const HomeNavbarPage({super.key});

  @override
  State<HomeNavbarPage> createState() => _HomeNavbarPageState();
}

class _HomeNavbarPageState extends State<HomeNavbarPage> {
  final String apiUrl = '$baseUrl/symptoms/';
  int currentPage = 0;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        // Jika tidak ada token di SharedPreferences, lanjutkan untuk mengecek di API
        _redirectToLogin(); // Redirect to login as there is no token
      } else {
        // Jika token sudah ada di SharedPreferences, lanjutkan untuk mengecek di API
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          // Jika token valid di API, set isAuthenticated menjadi true
          setState(() {
            isAuthenticated = true;
          });
          print('Bearer Token: $token'); // Print the bearer token

          return;
        } else {
          // Jika token tidak valid, atau terdapat error lain, redirect ke halaman login
          _redirectToLogin();
          return;
        }
      }
    } catch (e) {
      // Tangani kesalahan lain jika terjadi
      print('Error during authentication check: $e');
      _redirectToLogin();
    }
  }

  void _redirectToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  List<Widget> pages = const [
    HomePage(),
    PredictPage(),
    PostTravelPage(),
    RiwayatPerjalanan()
  ];

  @override
  Widget build(BuildContext context) {
    return isAuthenticated
        ? Scaffold(
            appBar: Header(context, titleText: "Travel Healthcare"),
            body: pages[currentPage],
            bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior
                  .alwaysShow, // Selalu tampilkan label
              destinations: const [
                NavigationDestination(
                  icon: Icon(Iconsax.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.shield_search),
                  label: 'monitor disease',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.element_plus),
                  label: 'Diagnosis',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.clipboard_text),
                  label: 'My Travel',
                ),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              selectedIndex: currentPage,
            ),
          )
        : Container(); // Return an empty container while checking authentication
  }
}
