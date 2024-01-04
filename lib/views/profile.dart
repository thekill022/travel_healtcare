import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/userdata_controller.dart';
import 'package:travel_healthcare/views/data_diri.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userdatactrl = UserDataController(isEdit: false);

  int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataDiri(
                              isEdit: true,
                            )));
              },
              child: const Text("Data Diri")),
        ),
      )),
    );
  }
}
