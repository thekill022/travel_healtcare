import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/symptom_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';

class PostTravelPage extends StatefulWidget {
  const PostTravelPage({Key? key}) : super(key: key);

  @override
  State<PostTravelPage> createState() => _PostTravelPageState();
}

class _PostTravelPageState extends State<PostTravelPage> {
  SymptomController symptomController = SymptomController();
  //List<SymptomModel> listsymptom = [];

  late Future<List<SymptomModel>> _symptoms;
  @override
  void initState() {
    super.initState();
    _symptoms = symptomController.getSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<SymptomModel>>(
          future: _symptoms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<SymptomModel> symptoms = snapshot.data!;

              // Use toSet() to remove duplicates based on symptomName
              List<SymptomModel> distinctSymptoms = symptoms.toSet().toList();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: distinctSymptoms.length,
                  itemBuilder: (context, index) {
                    SymptomModel symptom = distinctSymptoms[index];
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              symptom.symptomName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DropdownButtonFormField<SymptomModel>(
                            hint: const Text('Select a symptom'),
                            value: null, // Initially, no value is selected
                            onChanged: (SymptomModel? selectedSymptom) {
                              // Handle selected value
                            },
                            items: symptoms
                                .where(
                                    (s) => s.symptomName == symptom.symptomName)
                                .map((SymptomModel s) {
                              return DropdownMenuItem<SymptomModel>(
                                value: s,
                                child: Text(s.symptomChar),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
