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
  late Future<List<SymptomModel>> _symptoms;
  late List<SymptomModel> _filteredSymptoms;

  @override
  void initState() {
    super.initState();
    _symptoms = symptomController.getSymptoms();
    _filteredSymptoms = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  // Filter symptoms based on search keyword
                  _symptoms.then((symptoms) {
                    setState(() {
                      _filteredSymptoms = symptoms
                          .where((symptom) => symptom.symptomName
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Symptoms',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      // Clear the search field and reset the filtered list
                      setState(() {
                        _filteredSymptoms = [];
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
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
                    List<SymptomModel> symptoms = _filteredSymptoms.isNotEmpty
                        ? _filteredSymptoms
                        : snapshot.data!;

                    return SymptomList(symptoms: symptoms);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomList extends StatefulWidget {
  final List<SymptomModel> symptoms;

  const SymptomList({Key? key, required this.symptoms}) : super(key: key);

  @override
  _SymptomListState createState() => _SymptomListState();
}

class _SymptomListState extends State<SymptomList> {
  late List<bool> checkboxStatus;

  @override
  void initState() {
    super.initState();
    checkboxStatus = List<bool>.filled(widget.symptoms.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: widget.symptoms.length,
        itemBuilder: (context, index) {
          SymptomModel symptom = widget.symptoms[index];
          return SymptomCheckbox(
            symptom: symptom,
            isChecked: checkboxStatus[index],
            onChanged: (bool? value) {
              setState(() {
                checkboxStatus[index] = value ?? true;
                print(checkboxStatus);
              });
            },
          );
        },
      ),
    );
  }
}

class SymptomCheckbox extends StatelessWidget {
  final SymptomModel symptom;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  SymptomCheckbox({
    required this.symptom,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        title: Text(
          symptom.symptomName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
