import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';

class UpdateFormPerjalanan extends StatefulWidget {
  const UpdateFormPerjalanan(
      {super.key,
      this.kotaTujuan,
      this.provinsiTujuan,
      this.durasiTravel,
      this.tujuanTravel,
      this.id});

  final int? id;
  final String? kotaTujuan;
  final String? provinsiTujuan;
  final String? durasiTravel;
  final String? tujuanTravel;

  @override
  State<UpdateFormPerjalanan> createState() => _UpdateFormPerjalananState();
}

class _UpdateFormPerjalananState extends State<UpdateFormPerjalanan> {
  final _formKey = GlobalKey<FormState>();

  final travelhistoryCtrl = TravelHistoryController();

  Color myColor = Color(0xFFE0F4FF);

  String? newkotaTujuan;
  String? newprovinsiTujuan;
  String? newdurasiTravel;
  String? newtujuanTravel;

  void updateTravelHistory(int id) async {
    TravelHistoryModel travelHistoryModel = TravelHistoryModel(
        kotaTujuan: newkotaTujuan!,
        provinsiTujuan: newprovinsiTujuan!,
        durasiTravel: newdurasiTravel!,
        tujuanTravel: newtujuanTravel!);
    await travelhistoryCtrl.updateTravelHistory(id, travelHistoryModel);
  }

  @override
  void initState() {
    super.initState();
    newkotaTujuan = widget.kotaTujuan;
    newprovinsiTujuan = widget.provinsiTujuan;
    newdurasiTravel = widget.durasiTravel;
    newtujuanTravel = widget.tujuanTravel;
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
      appBar: HeaderSub(context, titleText: 'Edit Form'),
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
                    'Nama Kota Tujuan :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextFormField(
                  // controller: _kotaTujuan,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[
                        50], // Set the background color to light blue
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.black), // Set border color
                    ),
                  ),
                  onSaved: (value) {
                    newkotaTujuan = value;
                  },
                  initialValue: widget.kotaTujuan,
                ),
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
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: newprovinsiTujuan,
                    items: generateProvinsi(daftarProvinsi),
                    onChanged: (item) {
                      setState(() {
                        newprovinsiTujuan = item;
                      });
                    },
                  ),
                ),
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
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: newdurasiTravel,
                    items: generateDurasi(daftarDurasi),
                    onChanged: (item) {
                      setState(() {
                        newdurasiTravel = item;
                      });
                    },
                  ),
                ),
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
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor: Colors.lightBlueAccent,
                    value: newtujuanTravel,
                    items: generateTujuan(daftarTujuan),
                    onChanged: (item) {
                      setState(() {
                        newtujuanTravel = item;
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

                          updateTravelHistory(widget.id!);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Data Form Perjalanan berhasil diubah')));

                          Navigator.pop(context, true);
                          //Navigator.pop(context, true);
                        }
                      },
                      child: const Text("Edit"),
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
}
