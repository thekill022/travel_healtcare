import 'package:flutter/material.dart';
import 'package:travel_healthcare/components/header_sub.dart';
import 'package:travel_healthcare/controller/userdata_controller.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';
import 'package:travel_healthcare/model/user_model.dart';
import 'package:travel_healthcare/views/data_diri.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userdatactrl = UserDataController(isEdit: false);

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

  UserDataModel? crntuser;

  Color myColor = Color(0xFFE0F4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderSub(context, titleText: "Profil"),
      backgroundColor: myColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<UserModel>(
              future: userdatactrl.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Data not found');
                } else {
                  // Data user berhasil diambil, tampilkan nama dan email
                  UserModel currentUser = snapshot.data!;
                  print(
                      'Nama: ${currentUser.nama}, Email: ${currentUser.email}');

                  print('Umur: ${crntuser?.umur}');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Nama: ${currentUser.nama.toString()}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Email: ${currentUser.email.toString()}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataDiri(
                                  // umur: umur,
                                  // kondisiMedis: kondisiMedis,
                                  // pengobatan: pengobatan,
                                  // alergi: alergi,
                                  // reaksiVaksin: reaksiVaksin,
                                  // hamilMenyusui: hamilMenyusui,
                                  // vaccineBcg: vaccineBcg,
                                  // vaccineHepatitis: vaccineHepatitis,
                                  // vaccineDengue: vaccineDengue,
                                  // isEdit: true,
                                  ),
                            ),
                          );
                        },
                        child: const Text("Data Diri"),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
