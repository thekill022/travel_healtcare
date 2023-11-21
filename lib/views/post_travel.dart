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
  SymptomController symptomController = SymptomController();
  //List<SymptomModel> listsymptom = [];

  @override
  void initState() {
    super.initState();
    symptomController.getSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom List'),
      ),
      body: FutureBuilder<List<SymptomModel>>(
        future: symptomController.getSymptoms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<SymptomModel> symptoms = snapshot.data!;
            return ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                SymptomModel symptom = symptoms[index];
                return ListTile(
                  title: Text(symptom.symptomName),
                  subtitle: Text(symptom.symptomChar),
                );
              },
            );
          }
        },
      ),
    );
  }
}
