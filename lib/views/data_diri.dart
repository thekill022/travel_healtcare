import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/medicalscore_controller.dart';
import 'package:travel_healthcare/controller/userdata_controller.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';
import 'package:travel_healthcare/model/medical_score.dart';

class DataDiri extends StatefulWidget {
  DataDiri({
    Key? key,
  }) : super(key: key);

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  final _formKey = GlobalKey<FormState>();

  var userdatactrl = UserDataController(isEdit: true);
  MedicalScoreController medicalScoreController = MedicalScoreController();

  // int? userId;
  String? umur;
  String? kondisiMedis;
  String? pengobatan;
  String? alergi;
  String? reaksiVaksin;
  String? hamilMenyusui;
  // String? riwayatVaksin;
  bool? vaccineBcg;
  bool? vaccineHepatitis;
  bool? vaccineDengue;

  int? umurbobot;
  int? kondisiMedisbobot;
  int? pengobatanbobot;
  int? alergibobot;
  int? reaksiVaksinbobot;
  int? hamilMenyusuibobot;

  Future<void> addDataDiri() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (umur == null ||
          kondisiMedis == null ||
          pengobatan == null ||
          alergi == null ||
          reaksiVaksin == null ||
          hamilMenyusui == null) {
        // Handle empty data case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complete all data before saving')),
        );
        return;
      }

      UserDataModel userDataModel = UserDataModel(
        umur: umur!,
        kondisiMedis: kondisiMedis!,
        pengobatan: pengobatan!,
        alergi: alergi!,
        reaksiVaksin: reaksiVaksin!,
        hamilMenyusui: hamilMenyusui!,
        vaccineBcg: vaccineBcg,
        vaccineHepatitis: vaccineHepatitis,
        vaccineDengue: vaccineDengue,
      );
      await userdatactrl.createUserData(userDataModel);

      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Data diri berhasil disimpan')));

      // Navigator.pop(context, true);
    }
  }

  Future<void> addMedicalScore() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (umur == null ||
          kondisiMedis == null ||
          pengobatan == null ||
          alergi == null ||
          reaksiVaksin == null ||
          hamilMenyusui == null) {
        // Handle empty data case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complete all data before saving')),
        );
        return;
      }

      MedicalScore medicalScore = MedicalScore(
        umurbobot: umurbobot!,
        kondisiMedisbobot: kondisiMedisbobot!,
        pengobatanbobot: pengobatanbobot!,
        alergibobot: alergibobot!,
        reaksiVaksinbobot: reaksiVaksinbobot!,
        hamilMenyusuibobot: hamilMenyusuibobot!,
        categories: '',
      );
      await medicalScoreController.createMedicalScore(medicalScore);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Personal data successfully saved')));

      Navigator.pop(context, true);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null) {
        List<UserDataModel> userDataList = await userdatactrl.getUserData();

        if (userDataList.isNotEmpty) {
          UserDataModel userData = userDataList.last;

          List<MedicalScore> medicalScores =
              await medicalScoreController.getMedicalScore();

          if (medicalScores.isNotEmpty) {
            MedicalScore medicalScore = medicalScores.last;

            setState(() {
              umur = userData.umur;
              kondisiMedis = userData.kondisiMedis;
              pengobatan = userData.pengobatan;
              alergi = userData.alergi;
              reaksiVaksin = userData.reaksiVaksin;
              hamilMenyusui = userData.hamilMenyusui;
              vaccineBcg = userData.vaccineBcg;
              vaccineHepatitis = userData.vaccineHepatitis;
              vaccineDengue = userData.vaccineDengue;

              // Set the weights
              umurbobot = medicalScore.umurbobot;
              kondisiMedisbobot = medicalScore.kondisiMedisbobot;
              pengobatanbobot = medicalScore.pengobatanbobot;
              alergibobot = medicalScore.alergibobot;
              reaksiVaksinbobot = medicalScore.reaksiVaksinbobot;
              hamilMenyusuibobot = medicalScore.hamilMenyusuibobot;
            });
          } else {
            // Handle the case when medical scores are empty
            print('Medical scores are empty');
          }
        } else {
          // Handle the case when data is empty
          print('User data is empty');
        }
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching user data: $e');
    }
  }

  List<String> ket = ['Under 65 years', 'Over 65 years'];
  List<int> ketBobot = [0, 15];

  List<DropdownMenuItem> generateItems(List<String> ket, List<int> ketBobot) {
    List<DropdownMenuItem> items = [];
    for (var i = 0; i < ket.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(ket[i]),
        value: ket[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            umur = ket[i];
            umurbobot = ketBobot[i];
          });
        },
      ));
    }
    return items;
  }

  List<String> kondisimed = [
    'High blood pressure',
    'heart disease',
    'Blood clotting disorders',
    'Kidney dysfunction',
    'Epilepsy',
    'Spleen damage',
    'Cancer',
    'HIV/AIDS',
    'Autoimmune disease',
    'Mental disorder/depression',
    'Lung disease',
    'Diabetes',
    'Inflammatory bowel disease',
    'Liver disease',
    'Thymus gland removal',
    'Other',
    'No disease'
  ];

  List<int> kondisimedbobot = [
    5,
    10,
    10,
    5,
    10,
    20,
    10,
    20,
    20,
    20,
    5,
    10,
    20,
    10,
    20,
    5,
    0
  ];

  List<DropdownMenuItem> generateKondisi(
      List<String> kondisimed, List<int> kondisimedbobot) {
    List<DropdownMenuItem> items2 = [];
    for (var i = 0; i < kondisimed.length; i++) {
      items2.add(DropdownMenuItem(
        child: Text(kondisimed[i]),
        value: kondisimed[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            kondisiMedis = kondisimed[i];
            kondisiMedisbobot = kondisimedbobot[i];
          });
        },
      ));
    }
    return items2;
  }

  List<String> obat = [
    'antihypertensive drugs',
    'cortisone',
    'blood thinners',
    'immunosuppressive drugs',
    'chemotherapy',
    'radiotherapy',
    'antibiotics',
    'antidepressants',
    'hormones (such as contraceptive pills)',
    'antiviral drugs',
    'allergen desensitization therapy',
    'others',
    'no drugs'
  ];

  List<int> obatbobot = [5, 10, 20, 20, 20, 10, 10, 10, 5, 5, 5, 5, 0];

  List<DropdownMenuItem> generateObat(List<String> obat, List<int> obatbobot) {
    List<DropdownMenuItem> items3 = [];
    for (var i = 0; i < obat.length; i++) {
      items3.add(DropdownMenuItem(
        child: Text(obat[i]),
        value: obat[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            pengobatan = obat[i];
            pengobatanbobot = obatbobot[i];
          });
        },
      ));
    }
    return items3;
  }

  List<String> alergidd = [
    'chicken or egg',
    'Fever',
    'Asthma',
    'Antibiotics',
    'Bee or wasp sting',
    'Other',
    'No allergies'
  ];

  List<int> alergiddbobot = [20, 0, 5, 10, 20, 5, 0];

  List<DropdownMenuItem> generateAlergi(
      List<String> alergidd, List<int> alergiddbobot) {
    List<DropdownMenuItem> items4 = [];
    for (var i = 0; i < alergidd.length; i++) {
      items4.add(DropdownMenuItem(
        child: Text(alergidd[i]),
        value: alergidd[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            alergi = alergidd[i];
            alergibobot = alergiddbobot[i];
          });
        },
      ));
    }
    return items4;
  }

  List<String> reakvaksin = ['Yes', 'No'];
  List<int> reakvaksinbobot = [20, 0];

  List<DropdownMenuItem> generateReakvaksin(
      List<String> reakvaksin, List<int> reakvaksinbobot) {
    List<DropdownMenuItem> items5 = [];
    for (var i = 0; i < reakvaksin.length; i++) {
      items5.add(DropdownMenuItem(
        child: Text(reakvaksin[i]),
        value: reakvaksin[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            reaksiVaksin = reakvaksin[i];
            reaksiVaksinbobot = reakvaksinbobot[i];
          });
        },
      ));
    }
    return items5;
  }

  List<String> busui = ['Ya', 'Tidak'];
  List<int> busuibobot = [20, 0];

  List<DropdownMenuItem> generateBusui(
      List<String> busui, List<int> busuibobot) {
    List<DropdownMenuItem> items6 = [];
    for (var i = 0; i < busui.length; i++) {
      items6.add(DropdownMenuItem(
        child: Text(busui[i]),
        value: busui[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            hamilMenyusui = busui[i];
            hamilMenyusuibobot = busuibobot[i];
          });
        },
      ));
    }
    return items6;
  }

  Color myColor = Color(0xFFE0F4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: "Personal data"),
      backgroundColor: myColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Age : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Flexible(
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.lightBlueAccent,
                        hint: const Text('Select your age'),
                        value: umur,
                        items: generateItems(ket, ketBobot),
                        onChanged: (item) {
                          setState(() {
                            umur = item;
                          });
                        },
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Previous medical conditions :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Flexible(
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.lightBlueAccent,
                        hint: const Text('Select previous medical conditions'),
                        value: kondisiMedis,
                        items: generateKondisi(kondisimed, kondisimedbobot),
                        onChanged: (item2) {
                          setState(() {
                            kondisiMedis = item2;
                          });
                        },
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Current treatment :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Flexible(
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.lightBlueAccent,
                        hint: const Text('Choose your current treatment'),
                        value: pengobatan,
                        items: generateObat(obat, obatbobot),
                        onChanged: (item3) {
                          setState(() {
                            pengobatan = item3;
                          });
                        },
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Allergy :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Flexible(
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.lightBlueAccent,
                        hint: const Text('select your allergies'),
                        value: alergi,
                        items: generateAlergi(alergidd, alergiddbobot),
                        onChanged: (item4) {
                          setState(() {
                            alergi = item4;
                          });
                        },
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Reaction to previous vaccine :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Flexible(
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.lightBlueAccent,
                        hint: const Text('choose your reaction to the vaccine'),
                        value: reaksiVaksin,
                        items: generateReakvaksin(reakvaksin, reakvaksinbobot),
                        onChanged: (item5) {
                          setState(
                            () {
                              reaksiVaksin = item5;
                            },
                          );
                        },
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Are you Pregnant/Breastfeeding :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Flexible(
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.lightBlueAccent,
                        hint: const Text('choose your answer'),
                        value: hamilMenyusui,
                        items: generateBusui(busui, busuibobot),
                        onChanged: (item6) {
                          setState(() {
                            hamilMenyusui = item6;
                          });
                        },
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Vaccine History :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  children: [
                    buildVaksinCheckbox('BCG vaccine', (value) {
                      setState(() {
                        vaccineBcg = value;
                      });
                    }),
                    buildVaksinCheckbox('Hepatitis A Vaccine (HAV)', (value) {
                      setState(() {
                        vaccineHepatitis = value;
                      });
                    }),
                    buildVaksinCheckbox('Dengue Vaccine', (value) {
                      setState(() {
                        vaccineDengue = value;
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          addDataDiri();
                          addMedicalScore();
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVaksinCheckbox(
      String vaksinName, void Function(bool?)? onChanged) {
    return Row(
      children: [
        Checkbox(
          value: onChanged != null
              ? vaksinName == 'BCG vaccine'
                  ? vaccineBcg ?? false
                  : vaksinName == 'Hepatitis A Vaccine (HAV)'
                      ? vaccineHepatitis ?? false
                      : vaccineDengue ?? false
              : false,
          onChanged: onChanged,
        ),
        Text(vaksinName),
      ],
    );
  }
}
