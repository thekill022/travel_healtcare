import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/getpretravel_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';
import 'package:travel_healthcare/model/getpretravel_model.dart';
import 'package:travel_healthcare/views/pratravel/detail_disease.dart';

class DiseaseList extends StatefulWidget {
  const DiseaseList({
    Key? key,
    required this.id,
    required this.countryname,
  }) : super(key: key);

  @override
  State<DiseaseList> createState() => _DiseaseListState();

  final int id;
  final String countryname;
}

class _DiseaseListState extends State<DiseaseList> {
  GetPreTravelController getPreTravelController = GetPreTravelController();

  late Future<GetPreTravelModel> _getPreTravelModelFuture;

  @override
  void initState() {
    super.initState();
    _getPreTravelModelFuture =
        getPreTravelController.getDiseaseEndemic(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: '${widget.countryname}'),
      body: SafeArea(
        child: FutureBuilder<GetPreTravelModel>(
          future: _getPreTravelModelFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Reload data when the button is pressed
                          _getPreTravelModelFuture = getPreTravelController
                              .getDiseaseEndemic(widget.id);
                        });
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              // Assuming that GetPreTravelModel has a List<DiseaseModel> attribute
              List<DiseaseModel> diseaseList = snapshot.data!.diseaseEndemic;

              return ListView.builder(
                itemCount: diseaseList.length,
                itemBuilder: (context, index) {
                  DiseaseModel disease = diseaseList[index];
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailDisease(
                                      id: disease.id,
                                      diseaseName: disease.diseaseName,
                                      diseaseDesc: disease.diseaseDesc,
                                    )));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            disease.diseaseName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Text(disease.diseaseDesc),
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
