import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
  TextEditingController searchController = TextEditingController();
  late List<EndemicityModel> filteredEndemicityList;

  Color myColor = Color(0xFFE0F4FF);

  @override
  void initState() {
    super.initState();
    //filteredEndemicityList = [];
  }

  void filterEndemicityList(String query) {
    setState(() {
      filteredEndemicityList = endemicityController.endemicityList
          .where((endemicity) => endemicity.countryname
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (query) {
            filterEndemicityList(query);
          },
          decoration: InputDecoration(
            hintText: 'Cari provinsi tujuan anda',
            prefixIcon: const Icon(Iconsax.search_normal),
            filled: true,
            fillColor: myColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              // borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.only(top: 10.0),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<EndemicityModel>>(
          future: endemicityController.filterEndemicity(searchController.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              filteredEndemicityList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: filteredEndemicityList.length,
                itemBuilder: (context, index) {
                  EndemicityModel endemicity = filteredEndemicityList[index];
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
