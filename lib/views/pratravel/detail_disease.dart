import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/disease_controller.dart';
import 'package:travel_healthcare/controller/medicalscore_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';
import 'package:travel_healthcare/model/medical_score.dart';

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
  late List<MedicalScore> medicalScores;

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
    medicalScores = [];
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

      // Fetch the associated medical scores
      MedicalScoreController medicalScoreController = MedicalScoreController();
      List<MedicalScore> scores =
          await medicalScoreController.getMedicalScore();

      setState(() {
        disease = selectedDisease;
        medicalScores = scores;
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
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '${disease.diseaseName}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${disease.diseaseDesc}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 12),
                    for (var score in medicalScores)
                      Text(
                        'Resiko Medis : ${score.categories}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getColorBasedOnCategory(score.categories),
                        ),
                      ),
                    const SizedBox(height: 10),
                    for (var prevention in disease.prevention!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${prevention.titleprev}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            '${prevention.descprev}',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    const SizedBox(height: 12),
                    // for (var treatment in disease.treatment!)
                    //   Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('${treatment.titletreat}',
                    //           style: const TextStyle(
                    //               fontSize: 18, fontWeight: FontWeight.bold)),
                    //       Text(
                    //         '${treatment.desctreat}',
                    //         textAlign: TextAlign.justify,
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ),
    );
  }

  Color _getColorBasedOnCategory(String category) {
    switch (category) {
      case 'Tinggi':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Rendah':
        return Colors.yellow;
      case 'Tidak ada Resiko':
        return Colors.green;
      default:
        return Colors.black; // or any default color
    }
  }
}
