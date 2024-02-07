import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_healthcare/controller/posttravel_controller.dart';
import 'package:travel_healthcare/controller/symptom_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';
import 'package:travel_healthcare/model/diagnose_model.dart';
import 'package:travel_healthcare/views/login.dart';
import 'package:travel_healthcare/views/posttravel/disease_diagnose.dart';

class PostTravelPage extends StatefulWidget {
  const PostTravelPage({Key? key}) : super(key: key);

  @override
  State<PostTravelPage> createState() => _PostTravelPageState();
}

class _PostTravelPageState extends State<PostTravelPage> {
  TextEditingController searchController = TextEditingController();
  Color myColor = Color(0xFFE0F4FF);
  SymptomController symptomController = SymptomController();
  late Future<List<SymptomModel>> _symptoms;
  late List<SymptomModel> _allSymptoms = [];
  late List<SymptomModel> _filteredSymptoms = [];
  late Map<int, bool> _temporaryCheckboxStatus = {};

  @override
  void initState() {
    super.initState();
    _symptoms = symptomController.getSymptoms();
  }

  void filterSymptomList(String query) {
    List<SymptomModel> filteredData = _allSymptoms
        .where((symptom) =>
            symptom.symptomName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredSymptoms = filteredData;
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
            hintText: 'Cari gejala anda',
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
                    Future.delayed(Duration.zero, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    });

                    return const Center(
                      child: Text('Anda belum login'),
                    );
                  } else {
                    _allSymptoms = snapshot.data!;
                    List<SymptomModel> symptoms = _filteredSymptoms.isNotEmpty
                        ? _filteredSymptoms
                        : _allSymptoms;
                    return SymptomList(
                      symptoms: symptoms,
                      temporaryCheckboxStatus: _temporaryCheckboxStatus,
                      onCheckboxChanged: (index, value) {
                        setState(() {
                          _temporaryCheckboxStatus[index] = value;
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton.icon(
            onPressed: () async {
              List<int> selectedIds = _temporaryCheckboxStatus.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();

              try {
                List<DiagnoseModel> diagnoses = await PostTravelController()
                    .createTravelHistory(selectedIds);

                // DiagnoseResult diubah menjadi List<DiagnoseModel>
                // Karena createTravelHistory mengembalikan List<DiagnoseModel>
                if (diagnoses.isNotEmpty) {
                  // Cek apakah ada hasil diagnosa
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseaseDiagnosePage(
                        diagnosisData: diagnoses,
                      ),
                    ),
                  );
                } else {
                  // Tidak ada hasil diagnosa
                  print('No diseases detected.');
                }
              } catch (e) {
                // Handle error
                print('Error: $e');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor,
            ),
            icon: Icon(Iconsax.shield_tick),
            label: Text('Diagnosa'),
          ),
        ),
      ),
    );
  }
}

class SymptomList extends StatefulWidget {
  final List<SymptomModel> symptoms;
  final Map<int, bool> temporaryCheckboxStatus;
  final Function(int, bool) onCheckboxChanged;

  const SymptomList({
    Key? key,
    required this.symptoms,
    required this.temporaryCheckboxStatus,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  _SymptomListState createState() => _SymptomListState();
}

class _SymptomListState extends State<SymptomList> {
  late List<bool> _checkboxStatus;

  @override
  void initState() {
    super.initState();
    _initCheckboxStatus();
  }

  void _initCheckboxStatus() {
    // Inisialisasi _checkboxStatus dan tetapkan nilai default
    _checkboxStatus = List<bool>.generate(widget.symptoms.length, (index) {
      // Tentukan bahwa semua nilai adalah false
      return false;
    });
  }

  @override
  void didUpdateWidget(SymptomList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.symptoms.length != widget.symptoms.length) {
      // Jika panjang daftar gejala berubah, inisialisasi kembali _checkboxStatus
      _initCheckboxStatus();
    }
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
            isChecked: _checkboxStatus[index],
            onChanged: (bool? value) {
              setState(() {
                _checkboxStatus[index] = value ?? false;
                widget.onCheckboxChanged(symptom.id, _checkboxStatus[index]);
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
