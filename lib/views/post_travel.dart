import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/symptom_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';
import 'package:http/http.dart' as http;

class PostTravelPage extends StatefulWidget {
  const PostTravelPage({Key? key}) : super(key: key);

  @override
  State<PostTravelPage> createState() => _PostTravelPageState();
}

class _PostTravelPageState extends State<PostTravelPage> {
  SymptomController symptomController = SymptomController();
  List<SymptomModel> listsymptom = [];

  String? selectSymptom;
  final String apiUrl = 'http://10.0.2.2:5000/api/symptoms/';
  String? stringResponse;

  Future symptomCall() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          stringResponse = response.body;
        });
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the function to fetch symptoms when the widget is created
    symptomCall();
    fetchSymptoms();
  }

  void fetchSymptoms() async {
    try {
      List<SymptomModel> symptoms = await symptomController.fetchSymptoms();

      setState(() {
        listsymptom = symptoms;
      });
    } catch (e) {
      print('Error fetching symptoms: $e');
      // Handle error accordingly (e.g., show an error message)
    }
  }

  List<DropdownMenuItem<SymptomModel>> generateItems(List<SymptomModel> list) {
    return list.map((symptom) {
      return DropdownMenuItem(
        child: Text(symptom.symptomChar),
        value: symptom,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: listsymptom.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                child: Column(
                  children: [
                    Text(listsymptom[index].symptomName),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.only(right: 250),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        dropdownColor: const Color.fromARGB(255, 223, 121, 238),
                        value: selectSymptom,
                        items: generateItems(listsymptom),
                        onChanged: (item) {
                          setState(() {
                            selectSymptom = item as String?;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
