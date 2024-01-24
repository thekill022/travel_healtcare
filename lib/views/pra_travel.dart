import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/endemicity_controller.dart';
import 'package:travel_healthcare/model/endemicity_model.dart';

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
