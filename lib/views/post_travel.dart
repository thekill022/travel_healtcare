import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/symptom_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';

class PostTravelPage extends StatefulWidget {
  const PostTravelPage({super.key});

  @override
  State<PostTravelPage> createState() => _PostTravelPageState();
}

class _PostTravelPageState extends State<PostTravelPage> {
  SymptomController symptomController = SymptomController();
  List<SymptomModel> listsymptom = [];

  String? selectSymptom;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch symptoms when the widget is created
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

  List<DropdownMenuItem> generateItems(List<String> list) {
    List<DropdownMenuItem> items = [];
    for (var item in list) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
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
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                      dropdownColor: const Color.fromARGB(255, 223, 121, 238),
                      value: selectSymptom,
                      items: generateItems(listsymptom.cast<String>()),
                      onChanged: (item) {
                        setState(() {
                          selectSymptom = item;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
