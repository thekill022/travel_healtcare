import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/userdata_controller.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';

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
          const SnackBar(
              content: Text('Lengkapi semua data sebelum menyimpan')),
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

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data diri berhasil disimpan')));

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
          });
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

  List<String> ket = ['Kurang dari 65 tahun', 'Lebih dari 65 tahun'];

  List<DropdownMenuItem> generateItems(List<String> ket) {
    List<DropdownMenuItem> items = [];
    for (var item in ket) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  List<String> kondisimed = [
    'Tekanan darah tinggi',
    'penyakit jantung',
    'Gangguan pembekuan darah',
    'Disfungsi ginjal',
    'Epilepsi',
    'Kerusakan limpa',
    'Kanker',
    'HIV/AIDS',
    'Penyakit autoimun',
    'Gangguan jiwa/depresi',
    'Penyakit paru-paru',
    'Kencing manis',
    'Penyakit radang usus',
    'Pengangkatan kelenjar timus',
    'Lainnya',
    'Tidak ada penyakit'
  ];

  List<DropdownMenuItem> generateKondisi(List<String> kondisimed) {
    List<DropdownMenuItem> items2 = [];
    for (var item2 in kondisimed) {
      items2.add(DropdownMenuItem(
        child: Text(item2),
        value: item2,
      ));
    }
    return items2;
  }

  List<String> obat = [
    'obat antihipertensi',
    'kortison',
    'obat pengencer darah',
    'Obat imunosupresif',
    'Kemoterapi',
    'Radioterapi',
    'Antibiotik',
    'Antidepresan',
    'Hormon (seperti pil kontrasepsi)',
    'Obat antivirus',
    'Terapi desensitisasi alergen',
    'Lainnya',
    'Tidak ada obat'
  ];

  List<DropdownMenuItem> generateObat(List<String> obat) {
    List<DropdownMenuItem> items3 = [];
    for (var item3 in obat) {
      items3.add(DropdownMenuItem(
        child: Text(item3),
        value: item3,
      ));
    }
    return items3;
  }

  List<String> alergidd = [
    'ayam atau telur',
    'Demam',
    'Asma',
    'Antibiotik',
    'Sengatan lebah atau tawon',
    'Lainnya',
    'Tidak ada alergi'
  ];

  List<DropdownMenuItem> generateAlergi(List<String> alergidd) {
    List<DropdownMenuItem> items4 = [];
    for (var item4 in alergidd) {
      items4.add(DropdownMenuItem(
        child: Text(item4),
        value: item4,
      ));
    }
    return items4;
  }

  List<String> reakvaksin = ['Ya', 'Tidak'];

  List<DropdownMenuItem> generateReakvaksin(List<String> reakvaksin) {
    List<DropdownMenuItem> items5 = [];
    for (var item5 in reakvaksin) {
      items5.add(DropdownMenuItem(
        child: Text(item5),
        value: item5,
      ));
    }
    return items5;
  }

  List<String> busui = ['Ya', 'Tidak'];

  List<DropdownMenuItem> generateBusui(List<String> busui) {
    List<DropdownMenuItem> items6 = [];
    for (var item6 in busui) {
      items6.add(DropdownMenuItem(
        child: Text(item6),
        value: item6,
      ));
    }
    return items6;
  }

  Color myColor = Color(0xFFE0F4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: "Data Diri"),
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
                    'Umur : ',
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
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 130),
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
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    hint: const Text('pilih umur anda'),
                    value: umur,
                    items: generateItems(ket),
                    onChanged: (item) {
                      setState(() {
                        umur = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Kondisi medis sebelumnya :',
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
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 65),
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
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    hint: const Text('pilih kondisi medis sebelumnya'),
                    value: kondisiMedis,
                    items: generateKondisi(kondisimed),
                    onChanged: (item2) {
                      setState(() {
                        kondisiMedis = item2;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Pengobatan saat ini :',
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
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 42),
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
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    hint: const Text('pilih pengobatan anda saat ini'),
                    value: pengobatan,
                    items: generateObat(obat),
                    onChanged: (item3) {
                      setState(() {
                        pengobatan = item3;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Alergi :',
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
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 90),
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
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    hint: const Text('pilih alergi anda'),
                    value: alergi,
                    items: generateAlergi(alergidd),
                    onChanged: (item4) {
                      setState(() {
                        alergi = item4;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Reaksi terhadap vaksin sebelumnya :',
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
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 50),
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
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    hint: const Text('pilih reaksi anda terhadap vaksin'),
                    value: reaksiVaksin,
                    items: generateReakvaksin(reakvaksin),
                    onChanged: (item5) {
                      setState(
                        () {
                          reaksiVaksin = item5;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Apakah anda Hamil/Menyusui :',
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
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 150),
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
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    hint: const Text('pilih jawaban anda'),
                    value: hamilMenyusui,
                    items: generateBusui(busui),
                    onChanged: (item6) {
                      setState(() {
                        hamilMenyusui = item6;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Riwayat Vaksin :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  children: [
                    buildVaksinCheckbox('Vaksin BCG', (value) {
                      setState(() {
                        vaccineBcg = value;
                      });
                    }),
                    buildVaksinCheckbox('Vaksin Hepatitis A (HAV)', (value) {
                      setState(() {
                        vaccineHepatitis = value;
                      });
                    }),
                    buildVaksinCheckbox('Vaksin Dengue', (value) {
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
                        }
                      },
                      child: const Text("Simpan"),
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
              ? vaksinName == 'Vaksin BCG'
                  ? vaccineBcg ?? false
                  : vaksinName == 'Vaksin Hepatitis A (HAV)'
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
