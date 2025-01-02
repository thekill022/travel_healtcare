import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/controller/travelscore_controller.dart';
import 'package:travel_healthcare/model/getCitiesData_model.dart';
import 'package:travel_healthcare/model/getCountryData_model.dart';
import 'package:travel_healthcare/model/getProvinceData_model.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';
import 'package:travel_healthcare/model/travelscore_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String? negaraTujuan;
  String? kotaTujuan;
  String? provinsiTujuan;
  String? formattgl;
  String? durasiTravel;
  String? tujuanTravel;

  int? provinsiTujuanbobot;
  int? durasiTravelbobot;
  int? tujuanTravelbobot;

  Future<void> addTravelHistory() async {
    if (negaraTujuan == null) {
      // Handle empty data case
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Destination country must be selected')));
      return;
    }

    TravelHistoryModel travelHistoryModel = TravelHistoryModel(
      negaraTujuan: negaraTujuan!,
      kotaTujuan: (kotaTujuan) ?? "Not Found",
      provinsiTujuan: (provinsiTujuan) ?? "",
      formattgl: formattgl!,
      durasiTravel: durasiTravel!,
      tujuanTravel: tujuanTravel!,
    );

    await travelhistoryCtrl.createTravelHistory(travelHistoryModel);

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Data Form Perjalanan berhasil disimpan')));

    //Navigator.pop(context, true);
  }

  Future<void> addTravelScore() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (negaraTujuan == null ||
          durasiTravel == null ||
          tujuanTravel == null) {
        // Handle empty data case
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Complete all data before saving')));
        return;
      }

      TravelScoreModel travelScoreModel = TravelScoreModel(
        provinsiTujuanBobot: provinsiTujuanbobot!,
        durasiTravelBobot: durasiTravelbobot!,
        tujuanTavelBobot: tujuanTravelbobot!,
        categories: '',
      );
      await travelScoreController.createTravelScore(travelScoreModel);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Travel Form Data successfully saved')));

      Navigator.pop(context, true);
    }
    return;
  }

  List<int> daftarprovinsibobot = [70];

  Future<List<Country>> getDataCountry() async {
    try {
      final response = await http.get(
          Uri.parse("https://api.countrystatecity.in/v1/countries"),
          headers: {
            "X-CSCAPI-KEY":
                "UXlSNVBtQWNxWlBEaTJwd215Y3dGTGIzWUJHaDRlZGZvWTA2TTVrZQ=="
          });
      final bodyRes = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return bodyRes.map((e) {
          final map = e as Map<String, dynamic>;

          return Country(name: map['name'], iso2: map['iso2']);
        }).toList();
      }
    } on SocketException {
      throw Exception("No Internet");
    }
    throw Exception("Error While Fetching Data");
  }

  Future<List<States>> getDataStates(String? iso2) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.countrystatecity.in/v1/countries/$iso2/states"),
          headers: {
            "X-CSCAPI-KEY":
                "UXlSNVBtQWNxWlBEaTJwd215Y3dGTGIzWUJHaDRlZGZvWTA2TTVrZQ=="
          });
      final bodyRes = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return bodyRes.map((e) {
          final map = e as Map<String, dynamic>;

          return States(name: map['name'], iso2: map['iso2']);
        }).toList();
      }
    } on SocketException {
      throw Exception("No Internet");
    }
    throw Exception("Error While Fetching Data");
  }

  Future<List<Cities>> getDataCities(
      String? iso2Country, String? iso2State) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.countrystatecity.in/v1/countries/$iso2Country/states/$iso2State/cities"),
          headers: {
            "X-CSCAPI-KEY":
                "UXlSNVBtQWNxWlBEaTJwd215Y3dGTGIzWUJHaDRlZGZvWTA2TTVrZQ=="
          });
      final bodyRes = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return bodyRes.map((e) {
          final map = e as Map<String, dynamic>;

          return Cities(name: map['name']);
        }).toList();
      }
    } on SocketException {
      throw Exception("No Internet");
    }
    throw Exception("Error While Fetching Data");
  }

  List<String> daftarDurasi = [
    '1 - 7 Days',
    '8 - 30 Days',
    '31 days to 6 months',
    'more than 6 months'
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
    'Studying outside the area',
    'Backpacker',
    'Travel for work',
    'Visiting friends and relatives',
    'Holiday',
    'Traveling outside the area',
    'Safari',
    'Sports activities',
    'Cruising',
    'Volunteering',
    'Highland areas',
    'Pilgrimage',
    'others'
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

  var selectedCountry, selectedState, selectedCities, isoCountry, isoState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: 'Travel Form'),
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
                      'Select Country :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: FutureBuilder<List<Country>>(
                        future: getDataCountry(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      validateCountry(negaraTujuan) ?? 'null'),
                                  value: selectedCountry,
                                  items: snapshot.data!.map((e) {
                                    return DropdownMenuItem(
                                      value: e.iso2.toString(),
                                      child: Text(e.name.toString()),
                                      onTap: () {
                                        isoCountry = e.iso2;
                                        negaraTujuan = e.name;
                                        selectedState = null;
                                        selectedCities = null;
                                        provinsiTujuan = null;
                                        kotaTujuan = null;
                                        setState(() {});
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedCountry = value;
                                    print(isoCountry);
                                    setState(() {});
                                  }),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Select State :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: FutureBuilder<List<States>>(
                      future: getDataStates(isoCountry),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("Select State (Optional)"),
                              value: selectedState,
                              items: snapshot.data!.map((e) {
                                return DropdownMenuItem(
                                  value: e.iso2.toString(),
                                  child: Text(e.name.toString()),
                                  onTap: () {
                                    isoState = e.iso2;
                                    provinsiTujuan = e.name;
                                    kotaTujuan = null;
                                    setState(() {});
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectedState = value;
                                selectedCities = null;
                                setState(() {});
                              },
                            ),
                          );
                        } else {
                          return DropdownMenuItem(
                            child: Text("Select Country First"),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Select Cities :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: FutureBuilder<List<Cities>>(
                      future: getDataCities(isoCountry, isoState),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            isoCountry != null &&
                            isoState != null) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("Select City (Optional)"),
                              value: selectedCities,
                              items: snapshot.data!.map((e) {
                                return DropdownMenuItem(
                                  value: e.name.toString(),
                                  child: Text(e.name.toString()),
                                  onTap: () {
                                    kotaTujuan = e.name.toString();
                                    setState(() {});
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectedCities = value;
                                setState(() {});
                              },
                            ),
                          );
                        } else {
                          return DropdownMenuItem(
                            child: Text("Select State First"),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'departure date :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: TextFormField(
                      controller: inputtgl,
                      decoration: InputDecoration(
                        hintText: 'select your departure date',
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
                      'travel duration :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: myColor,
                        hint: const Text('Select Travel Duration'),
                        value: durasiTravel,
                        items: generateDurasi(daftarDurasi, daftarDurasibobot),
                        onChanged: (item) {
                          setState(() {
                            durasiTravel = item;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'purpose of travel :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: myColor,
                        hint: const Text('Select Purpose'),
                        value: tujuanTravel,
                        items: generateTujuan(daftarTujuan, daftarTujuanbobot),
                        onChanged: (item) {
                          setState(() {
                            tujuanTravel = item;
                          });
                        },
                      ),
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
                            var snackBar = const SnackBar(
                              content: Text('Data Added Successfully'),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
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
      ),
    );
  }
}

String? validateCountry(String? value) {
  if (value == null || value == "null") {
    return "must choose one country";
  }
  return null;
}

String? validateTanggal(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter the date";
  }
  return null;
}
