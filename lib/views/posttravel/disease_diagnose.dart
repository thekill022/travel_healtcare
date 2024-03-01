import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/model/diagnose_model.dart';
import 'package:travel_healthcare/views/posttravel/detail_diagnose.dart';

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
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailDiagnose(
                diseaseId: diagnose.diseaseId,
                diseaseName: diagnose.diseaseName,
                diseaseDesc: diagnose.diseaseDesc,
              ),
            ),
          );
        },
        child: Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diagnose.diseaseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Persentase: ${diagnose.percentage}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Catatan: Semakin besar persentase, semakin besar kemungkinan penyakit.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 81, 134, 177),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${diagnose.percentage}%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
