import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/disease_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';

class DetailDiagnose extends StatefulWidget {
  const DetailDiagnose({
    Key? key,
    required this.diseaseId,
    required this.diseaseName,
    required this.diseaseDesc,
  }) : super(key: key);

  @override
  State<DetailDiagnose> createState() => _DetailDiagnoseState();

  final int diseaseId;
  final String diseaseName;
  final String diseaseDesc;
}

class _DetailDiagnoseState extends State<DetailDiagnose> {
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
        (disease) => disease.id == widget.diseaseId,
        orElse: () =>
            throw Exception('Disease not found with id ${widget.diseaseId}'),
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
        appBar: HeaderSub(context, titleText: 'Disease Details'),
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
                      // for (var prevention in disease.prevention!)
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text('${prevention.titleprev}',
                      //           style: const TextStyle(
                      //               fontSize: 18, fontWeight: FontWeight.bold)),
                      //       Text(
                      //         '${prevention.descprev}',
                      //         textAlign: TextAlign.justify,
                      //       ),
                      //     ],
                      //   ),
                      // const SizedBox(height: 12),
                      for (var treatment in disease.treatment!)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${treatment.titletreat}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                              '${treatment.desctreat}',
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
              child: const Text("Finished"),
            ),
          ),
        ));
  }
}
