import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/disease_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';

class DetailDisease extends StatefulWidget {
  const DetailDisease({
    Key? key,
    required this.id,
    required this.diseaseName,
    required this.diseaseDesc,
  }) : super(key: key);

  @override
  State<DetailDisease> createState() => _DetailDiseaseState();

  final int id;
  final String diseaseName;
  final String diseaseDesc;
}

class _DetailDiseaseState extends State<DetailDisease> {
  late DiseaseModel disease;

  @override
  void initState() {
    super.initState();
    // Initialize the disease field to an empty DiseaseModel
    disease = DiseaseModel(
      id: 0,
      diseaseName: widget.diseaseName,
      diseaseDesc: widget.diseaseDesc,
      diseaseSymptom: [],
      treatment: [],
      prevention: [],
    );
    // Fetch disease details when the widget is initialized
    fetchDiseaseDetails();
  }

  Future<void> fetchDiseaseDetails() async {
    try {
      // Assuming you have a DiseaseController instance available
      DiseaseController diseaseController = DiseaseController();

      List<DiseaseModel> diseases = await diseaseController.getDisease();

      // Find the disease with the specified id
      DiseaseModel selectedDisease = diseases.firstWhere(
        (disease) => disease.id == widget.id,
        orElse: () => throw Exception('Disease not found with id ${widget.id}'),
      );

      setState(() {
        disease = selectedDisease;
      });
    } catch (e) {
      print('Error fetching disease details: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: 'Detail Penyakit'),
      body: disease == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Penyakit: ${disease.diseaseName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Deskripsi Penyakit: ${disease.diseaseDesc}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Prevention:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var prevention in disease.prevention!)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- ${prevention.titleprev}'),
                        Text('  ${prevention.descprev}'),
                      ],
                    ),
                  SizedBox(height: 12),
                  Text(
                    'Treatment:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var treatment in disease.treatment!)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- ${treatment.titletreat}'),
                        Text('  ${treatment.desctreat}'),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
