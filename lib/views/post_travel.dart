import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_healthcare/controller/symptom_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';

class PostTravelPage extends StatefulWidget {
  const PostTravelPage({Key? key}) : super(key: key);

  @override
  State<PostTravelPage> createState() => _PostTravelPageState();
}

class _PostTravelPageState extends State<PostTravelPage> {
  TextEditingController searchController = TextEditingController();
  late List<SymptomModel> filteredSymptomList;

  Color myColor = Color(0xFFE0F4FF);
  SymptomController symptomController = SymptomController();
  late Future<List<SymptomModel>> _symptoms;
  // late List<SymptomModel> _filteredSymptoms;

  @override
  void initState() {
    super.initState();
    _symptoms = symptomController.getSymptoms();
    filteredSymptomList = []; // Initialize filteredSymptomList
  }

  void filterSymptomList(String query) async {
    List<SymptomModel> symptoms = await _symptoms;
    setState(() {
      filteredSymptomList = symptoms
          .where((symptom) =>
              symptom.symptomName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: searchController,
          onChanged: (query) {
            filterSymptomList(query);
          },
          decoration: InputDecoration(
            hintText: 'Search Symptoms',
            prefixIcon: const Icon(Iconsax.search_normal),
            filled: true,
            fillColor: myColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.only(top: 10.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                    List<SymptomModel> symptoms = filteredSymptomList.isNotEmpty
                        ? filteredSymptomList
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
