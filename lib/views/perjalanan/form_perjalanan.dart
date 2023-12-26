import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';

class FormPerjalanan extends StatefulWidget {
  const FormPerjalanan({super.key});

  @override
  State<FormPerjalanan> createState() => _FormPerjalananState();
}

class _FormPerjalananState extends State<FormPerjalanan> {
  final _formKey = GlobalKey<FormState>();

  Color myColor = Color(0xFFE0F4FF);

  final TextEditingController _kotaTujuan = TextEditingController();

  final travelhistoryCtrl = TravelHistoryController();

  String? kotaTujuan;
  String? provinsiTujuan;
  String? durasiTravel;
  String? tujuanTravel;

  Future<void> addTravelHistory() async {
    TravelHistoryModel travelHistoryModel = TravelHistoryModel(
        kotaTujuan: kotaTujuan!,
        provinsiTujuan: provinsiTujuan!,
        durasiTravel: durasiTravel!,
        tujuanTravel: tujuanTravel!);
    await travelhistoryCtrl.createTravelHistory(travelHistoryModel);
  }

  List<String> daftarProvinsi = [
    'Jawa Barat',
    'Jawa Timur',
    'Jawa Tengah',
    'Kalimantan Barat',
    'Kalimantan Timur',
    'Kalimantan Tengah'
  ];

  List<DropdownMenuItem> generateProvinsi(List<String> daftarProvinsi) {
    List<DropdownMenuItem> items = [];
    for (var item in daftarProvinsi) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  List<String> daftarDurasi = [
    '1 - 7 hari',
    '8 - 30 hari',
    '31 hari hingga 6 bulan',
    'lebih dari 6 bulan'
  ];

  List<DropdownMenuItem> generateDurasi(List<String> daftarDurasi) {
    List<DropdownMenuItem> items = [];
    for (var item in daftarDurasi) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  List<String> daftarTujuan = [
    'Belajar di luar daerah',
    'Backpaker',
    'Perjalanan untuk pekerjaan',
    'Mengunjungi teman dan kerabat',
    'Liburan',
    'Berpergian ke luar daerah',
    'Safari',
    'Kegiatan olahraga',
    'Pelayaran'
        'Kerja sukarela',
    'Daerah pegunungan tinggi',
    'Ziarah',
    'lainnya'
  ];

  List<DropdownMenuItem> generateTujuan(List<String> daftarTujuan) {
    List<DropdownMenuItem> items = [];
    for (var item in daftarTujuan) {
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
      appBar: HeaderSub(context, titleText: 'Form Perjalanan'),
      backgroundColor: myColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Nama Kota Tujuan :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _kotaTujuan,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Masukkan kota tujuan anda',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                        ),
                      ),
                      onSaved: (value) {
                        kotaTujuan = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Provinsi Tujuan :',
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: Colors.lightBlueAccent,
                      hint: const Text('pilih provinsi tujuan'),
                      value: provinsiTujuan,
                      items: generateProvinsi(daftarProvinsi),
                      onChanged: (item) {
                        setState(() {
                          provinsiTujuan = item;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Durasi Perjalanan :',
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: Colors.lightBlueAccent,
                      hint: const Text('pilih durasi travel'),
                      value: durasiTravel,
                      items: generateDurasi(daftarDurasi),
                      onChanged: (item) {
                        setState(() {
                          durasiTravel = item;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Tujuan Perjalanan :',
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
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: Colors.lightBlueAccent,
                      hint: const Text('pilih tujuan perjalanan'),
                      value: tujuanTravel,
                      items: generateTujuan(daftarTujuan),
                      onChanged: (item) {
                        setState(() {
                          tujuanTravel = item;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
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

                            addTravelHistory();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Data Form Perjalanan berhasil disimpan')));

                            Navigator.pop(context, true);
                            // Navigator.pop(context, true);
                            // Navigator.pop(context, true);
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
      ),
    );
  }
}
