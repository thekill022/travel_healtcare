import 'package:flutter/material.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({super.key});

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  final _formKey = GlobalKey<FormState>();

  String? nama;
  String? umur;
  String? kondisiMedis;
  String? pengobatan;
  String? alergi;
  String? reaksiVaksin;
  String? hamilMenyusui;
  // String? riwayatVaksin;

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

  List<String>? riwayatVaksin = [];

  final TextEditingController _nama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Nama :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _nama,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[
                        50], // Set the background color to light blue
                    // prefixIcon: const Icon(Icons.calendar_view_day_rounded)
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.black), // Set border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black, // Set the color to light blue
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    nama = value;
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Umur :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 130),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: umur,
                    items: generateItems(ket),
                    onChanged: (item) {
                      setState(() {
                        umur = item;
                      });
                    },
                  ),
                ),
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 70),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: kondisiMedis,
                    items: generateKondisi(kondisimed),
                    onChanged: (item2) {
                      setState(() {
                        kondisiMedis = item2;
                      });
                    },
                  ),
                ),
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 42),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: pengobatan,
                    items: generateObat(obat),
                    onChanged: (item3) {
                      setState(() {
                        pengobatan = item3;
                      });
                    },
                  ),
                ),
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 90),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: alergi,
                    items: generateAlergi(alergidd),
                    onChanged: (item4) {
                      setState(() {
                        alergi = item4;
                      });
                    },
                  ),
                ),
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 250),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: reaksiVaksin,
                    items: generateReakvaksin(reakvaksin),
                    onChanged: (item5) {
                      setState(() {
                        reaksiVaksin = item5;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Hamil/Menyusui :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 250),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: hamilMenyusui,
                    items: generateBusui(busui),
                    onChanged: (item5) {
                      setState(() {
                        hamilMenyusui = item5;
                      });
                    },
                  ),
                ),
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
                    buildVaksinCheckbox('Vaksin BCG'),
                    buildVaksinCheckbox('Vaksin Hepatitis A (HAV)'),
                    buildVaksinCheckbox('Vaksin Dengue'),
                  ],
                ),
                const SizedBox(height: 20),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Data Ibu Hamil berhasil diedit')));

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

  Widget buildVaksinCheckbox(String vaksinName) {
    return Row(
      children: [
        Checkbox(
          value: riwayatVaksin!.contains(vaksinName),
          onChanged: (bool? value) {
            setState(() {
              if (value!) {
                riwayatVaksin!.add(vaksinName);
              } else {
                riwayatVaksin!.remove(vaksinName);
              }
            });
          },
        ),
        Text(vaksinName),
      ],
    );
  }
}
