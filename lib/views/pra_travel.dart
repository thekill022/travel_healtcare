import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/model/endemicity_model.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({Key? key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  List<EndemicityModel> provinsiList = [];
  String selectedProvinsi = '';
  String penyakitName = '';
  String penyakitDescription = '';

  // Fungsi untuk mendapatkan daftar provinsi dari API
  Future<List<EndemicityModel>> fetchProvinsiList() async {
    try {
      // Mengambil Bearer token dari shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('token');

      if (bearerToken == null) {
        throw Exception('Bearer token not found in shared preferences');
      }

      // Menambahkan Bearer token ke header permintaan HTTP
      Map<String, String> headers = {'Authorization': 'Bearer $bearerToken'};

      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/api/endemics'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        List<EndemicityModel> provinsiListFromApi = List<EndemicityModel>.from(
          data.map((item) => EndemicityModel.fromJson(item)),
        );
        return provinsiListFromApi;
      } else {
        print('Failed to load data. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk mendapatkan data penyakit dari API berdasarkan provinsi
  Future<void> fetchData(String provinsi) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/pretravel/$provinsi'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        penyakitName = data['disease_name'] ?? '';
        penyakitDescription = data['disease_desc'] ?? '';
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    // Panggil fungsi fetchProvinsiList pada saat inisialisasi widget
    fetchProvinsiList().then((provinsiFromApi) {
      setState(() {
        provinsiList = provinsiFromApi;
        selectedProvinsi =
            provinsiList.isNotEmpty ? provinsiList[0].countryname ?? '' : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Halaman Pra Travel',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 5),
              DropdownButton<String>(
                value: selectedProvinsi,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedProvinsi = newValue!;
                    // Panggil fungsi fetchData saat provinsi dipilih
                    fetchData(selectedProvinsi);
                  });
                },
                items: provinsiList
                    .map<DropdownMenuItem<String>>((EndemicityModel? value) {
                  return DropdownMenuItem<String>(
                    value: value?.countryname ?? '',
                    child: Text(value?.countryname ?? ''),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              // Tampilkan nama penyakit dan deskripsi penyakit
              Text(
                'Nama Penyakit: $penyakitName',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Deskripsi Penyakit: $penyakitDescription',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PredictPage(),
  ));
}
