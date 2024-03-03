import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/controller/travelscore_controller.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';
import 'package:travel_healthcare/model/travelscore_model.dart';

class FormPerjalanan extends StatefulWidget {
  const FormPerjalanan({super.key});

  @override
  State<FormPerjalanan> createState() => _FormPerjalananState();
}

class _FormPerjalananState extends State<FormPerjalanan> {
  final _formKey = GlobalKey<FormState>();

  Color myColor = Color(0xFFE0F4FF);

  final TextEditingController _kotaTujuan = TextEditingController();
  final TextEditingController inputtgl = TextEditingController();

  final travelhistoryCtrl = TravelHistoryController();
  TravelScoreController travelScoreController = TravelScoreController();

  String? kotaTujuan;
  String? provinsiTujuan;
  String? formattgl;
  String? durasiTravel;
  String? tujuanTravel;

  int? durasiTravelbobot;
  int? tujuanTravelbobot;

  Future<void> addTravelHistory() async {
    if (kotaTujuan == null ||
        provinsiTujuan == null ||
        durasiTravel == null ||
        tujuanTravel == null) {
      // Handle empty data case
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Lengkapi semua data sebelum menyimpan')));
      return;
    }

    TravelHistoryModel travelHistoryModel = TravelHistoryModel(
      kotaTujuan: kotaTujuan!,
      provinsiTujuan: provinsiTujuan!,
      formattgl: formattgl!,
      durasiTravel: durasiTravel!,
      tujuanTravel: tujuanTravel!,
    );

    await travelhistoryCtrl.createTravelHistory(travelHistoryModel);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Data Form Perjalanan berhasil disimpan')));

    //Navigator.pop(context, true);
  }

  Future<void> addTravelScore() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (kotaTujuan == null ||
          provinsiTujuan == null ||
          durasiTravel == null ||
          tujuanTravel == null) {
        // Handle empty data case
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Lengkapi semua data sebelum menyimpan')));
        return;
      }

      TravelScoreModel travelScoreModel = TravelScoreModel(
        durasiTravelBobot: durasiTravelbobot!,
        tujuanTavelBobot: tujuanTravelbobot!,
        categories: '',
      );
      await travelScoreController.createTravelScore(travelScoreModel);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Data Form Perjalanan berhasil disimpan')));
    }
    return;
  }

  List<String> daftarProvinsi = [
    'Aceh',
    'Sumatera Utara',
    'Sumatera Barat',
    'Riau',
    'Kepulauan Riau',
    'Jambi',
    'Sumatera Selatan',
    'Bengkulu',
    'Lampung',
    'Bangka Belitung',
    'DKI Jakarta',
    'Jawa Barat',
    'Banten',
    'Jawa Tengah',
    'DI Yogyakarta',
    'Jawa Timur',
    'Bali',
    'Nusa Tenggara Barat',
    'Nusa Tenggara Timur',
    'Kalimantan Barat',
    'Kalimantan Tengah',
    'Kalimantan Selatan',
    'Kalimantan Timur',
    'Kalimantan Utara',
    'Gorontalo',
    'Sulawesi Barat',
    'Sulawesi Utara',
    'Sulawesi Tengah',
    'Sulawesi Selatan',
    'Sulawesi Tenggara',
    'Maluku',
    'Maluku Utara',
    'Papua Barat',
    'Papua',
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
  List<int> daftarDurasibobot = [0, 5, 10, 20];

  List<DropdownMenuItem> generateDurasi(
      List<String> daftarDurasi, List<int> daftarDurasibobot) {
    List<DropdownMenuItem> items = [];
    for (var i = 0; i < daftarDurasi.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(daftarDurasi[i]),
        value: daftarDurasi[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            durasiTravel = daftarDurasi[i];
            durasiTravelbobot = daftarDurasibobot[i];
          });
        },
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
    'Pelayaran',
    'Kerja sukarela',
    'Daerah pegunungan tinggi',
    'Ziarah',
    'lainnya'
  ];

  List<int> daftarTujuanbobot = [5, 20, 5, 10, 0, 10, 5, 10, 20, 20, 5, 10, 5];

  List<DropdownMenuItem> generateTujuan(
      List<String> daftarTujuan, List<int> daftarTujuanbobot) {
    List<DropdownMenuItem> items = [];
    for (var i = 0; i < daftarTujuan.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(daftarTujuan[i]),
        value: daftarTujuan[i],
        onTap: () {
          // Simpan bobot yang sesuai saat opsi dipilih
          setState(() {
            tujuanTravel = daftarTujuan[i];
            tujuanTravelbobot = daftarTujuanbobot[i];
          });
        },
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
                  const SizedBox(height: 5),
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
                      validator: validateKota,
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
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: myColor,
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
                      'Tanggal Keberangkatan:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
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
                      controller: inputtgl,
                      decoration: InputDecoration(
                        hintText: 'Masukkan kota tujuan anda',
                        suffixIcon: const Icon(Icons.event),
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
                      readOnly: true,
                      validator: validateTanggal,
                      onTap: () async {
                        DateTime? picktanggal = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (picktanggal != null) {
                          formattgl =
                              DateFormat('dd-MM-yyyy').format(picktanggal);

                          setState(() {
                            inputtgl.text = formattgl.toString();
                          });
                        }
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
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: myColor,
                      hint: const Text('pilih durasi travel'),
                      value: durasiTravel,
                      items: generateDurasi(daftarDurasi, daftarDurasibobot),
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
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: myColor,
                      hint: const Text('pilih tujuan perjalanan'),
                      value: tujuanTravel,
                      items: generateTujuan(daftarTujuan, daftarTujuanbobot),
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
                            addTravelScore();

                            Navigator.pop(context, true);
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

String? validateKota(String? value) {
  if (value == null || value.isEmpty) {
    return "Masukan Kota tujuan anda!";
  }
  return null;
}

String? validateTanggal(String? value) {
  if (value == null || value.isEmpty) {
    return "Tolong masukan tanggal ";
  }
  return null;
}
