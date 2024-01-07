import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/userdata_controller.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';

class DataDiri extends StatefulWidget {
  int? userId;
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
  final bool isEdit;
  DataDiri({
    Key? key,
    this.userId,
    this.umur,
    this.kondisiMedis,
    this.pengobatan,
    this.alergi,
    this.reaksiVaksin,
    this.hamilMenyusui,
    this.vaccineBcg,
    this.vaccineHepatitis,
    this.vaccineDengue,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  final _formKey = GlobalKey<FormState>();

  var userdatactrl = UserDataController(isEdit: true);

  // int? userId;
  String? umurbaru;
  String? kondisiMedisbaru;
  String? pengobatanbaru;
  String? alergibaru;
  String? reaksiVaksinbaru;
  String? hamilMenyusuibaru;
  // String? riwayatVaksin;
  bool? vaccineBcgbaru;
  bool? vaccineHepatitisbaru;
  bool? vaccineDenguebaru;

  Future<void> addDataDiri() async {
    UserDataModel userDataModel = UserDataModel(
      umur: umurbaru!,
      kondisiMedis: kondisiMedisbaru!,
      pengobatan: pengobatanbaru!,
      alergi: alergibaru!,
      reaksiVaksin: reaksiVaksinbaru!,
      hamilMenyusui: hamilMenyusuibaru!,
      vaccineBcg: vaccineBcgbaru,
      vaccineHepatitis: vaccineHepatitisbaru,
      vaccineDengue: vaccineDenguebaru,
      // userId: userId!,
    );
    await userdatactrl.createUserData(userDataModel);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      setState(() {
        umurbaru = widget.umur;
        kondisiMedisbaru = widget.kondisiMedis;
        pengobatanbaru = widget.pengobatan;
        alergibaru = widget.alergi;
        reaksiVaksinbaru = widget.reaksiVaksin;
        hamilMenyusuibaru = widget.hamilMenyusui;
        vaccineBcgbaru = widget.vaccineBcg;
        vaccineHepatitisbaru = widget.vaccineHepatitis;
        vaccineDenguebaru = widget.vaccineDengue;
      });
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
                    value: umurbaru,
                    items: generateItems(ket),
                    onChanged: (item) {
                      setState(() {
                        umurbaru = item;
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
                    value: kondisiMedisbaru,
                    items: generateKondisi(kondisimed),
                    onChanged: (item2) {
                      setState(() {
                        kondisiMedisbaru = item2;
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
                    value: pengobatanbaru,
                    items: generateObat(obat),
                    onChanged: (item3) {
                      setState(() {
                        pengobatanbaru = item3;
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
                    value: alergibaru,
                    items: generateAlergi(alergidd),
                    onChanged: (item4) {
                      setState(() {
                        alergibaru = item4;
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
                    value: reaksiVaksinbaru,
                    items: generateReakvaksin(reakvaksin),
                    onChanged: (item5) {
                      setState(() {
                        reaksiVaksinbaru = item5;
                      });
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
                    value: hamilMenyusuibaru,
                    items: generateBusui(busui),
                    onChanged: (item5) {
                      setState(() {
                        hamilMenyusuibaru = item5;
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
                        vaccineBcgbaru = value;
                      });
                    }),
                    buildVaksinCheckbox('Vaksin Hepatitis A (HAV)', (value) {
                      setState(() {
                        vaccineHepatitisbaru = value;
                      });
                    }),
                    buildVaksinCheckbox('Vaksin Dengue', (value) {
                      setState(() {
                        vaccineDenguebaru = value;
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
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Data diri berhasil disimpan')));

                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
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
                  ? vaccineBcgbaru ?? false
                  : vaksinName == 'Vaksin Hepatitis A (HAV)'
                      ? vaccineHepatitisbaru ?? false
                      : vaccineDenguebaru ?? false
              : false,
          onChanged: onChanged,
        ),
        Text(vaksinName),
      ],
    );
  }
}
