import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/endemicity_controller.dart';
import 'package:travel_healthcare/model/endemicity_model.dart';
import 'package:travel_healthcare/views/pratravel/disease_list.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({Key? key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  EndemicityController endemicityController = EndemicityController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<EndemicityModel>>(
          future: endemicityController.getEndemicity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<EndemicityModel> endemicityList = snapshot.data!;
              return ListView.builder(
                itemCount: endemicityList.length,
                itemBuilder: (context, index) {
                  EndemicityModel endemicity = endemicityList[index];
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiseaseList(
                              id: endemicity.id,
                              countryname: endemicity.countryname,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(endemicity.countryname),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
