import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/model/diagnose_model.dart';

class DiseaseDiagnosePage extends StatefulWidget {
  final List<DiagnoseModel> diagnosisData;

  const DiseaseDiagnosePage({Key? key, required this.diagnosisData})
      : super(key: key);

  @override
  State<DiseaseDiagnosePage> createState() => _DiseaseDiagnosePageState();
}

class _DiseaseDiagnosePageState extends State<DiseaseDiagnosePage> {
  Color myColor = Color(0xFFE0F4FF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: "Hasil Diagnosis"),
      backgroundColor: myColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.diagnosisData.isEmpty)
                  Text('Tidak ada penyakit yang terdeteksi.')
                else
                  Column(
                    children: widget.diagnosisData
                        .map((data) => DiseaseCard(diagnose: data))
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiseaseCard extends StatelessWidget {
  final DiagnoseModel diagnose;

  const DiseaseCard({Key? key, required this.diagnose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(diagnose.diseaseName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 250,
                child: Text(
                  '${diagnose.diseaseDesc}',
                  textAlign: TextAlign.justify,
                )),
            Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 81, 134, 177),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '${diagnose.percentage}%',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
