import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/symptom_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';
import 'package:http/http.dart' as http;

class PostTravelPage extends StatefulWidget {
  const PostTravelPage({Key? key}) : super(key: key);

  @override
  State<PostTravelPage> createState() => _PostTravelPageState();
}

class _PostTravelPageState extends State<PostTravelPage> {
  //SymptomController symptomController = SymptomController();
  //List<SymptomModel> listsymptom = [];

  String? selectSymptom;
  final String apiUrl = 'http://10.0.2.2:5000/api/symptoms/';
  //List<Iterable<dynamic>>? mapResponse; // Perbarui tipe data

  Map<String, dynamic>? mapResponse;

  Future symptomCall() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          mapResponse = json.decode(response.body);
        });
      } else {
        print('Response body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    symptomCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: mapResponse?.length ?? 0,
          itemBuilder: (context, index) {
            final Map<String, dynamic>? symptomData = mapResponse;
            // final SymptomModel symptom =
            //     SymptomModel.fromMap(symptomData as Map<String, dynamic>);

            return Card(
              child: Container(
                child: Column(
                  children: [
                    Text(symptomData?['symptom_name'].toString() ?? ''),
                    // ...
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
