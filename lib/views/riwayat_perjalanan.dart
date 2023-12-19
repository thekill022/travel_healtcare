import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';
import 'package:travel_healthcare/views/perjalanan/edit_form_perjalanan.dart';
import 'package:travel_healthcare/views/perjalanan/form_perjalanan.dart';

class RiwayatPerjalanan extends StatefulWidget {
  const RiwayatPerjalanan({super.key});

  @override
  State<RiwayatPerjalanan> createState() => _RiwayatPerjalananState();
}

class _RiwayatPerjalananState extends State<RiwayatPerjalanan> {
  final travelhistoryCtrl = TravelHistoryController();
  List<TravelHistoryModel> listtravelHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTravelHistory();
  }

  void getTravelHistory() async {
    final travelhistory = await travelhistoryCtrl.getTravelHistory();
    setState(() {
      listtravelHistory = travelhistory;
    });
  }

  void deleteTravelHistory(int id) async {
    await travelhistoryCtrl.deleteTravelHistory(id);
  }

  String? kotaTujuan;
  String? provinsiTujuan;
  String? durasiTravel;
  String? tujuanTravel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: listtravelHistory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateFormPerjalanan(
                        id: listtravelHistory[index].id,
                        kotaTujuan: listtravelHistory[index].kotaTujuan,
                        provinsiTujuan: listtravelHistory[index].provinsiTujuan,
                        durasiTravel: listtravelHistory[index].durasiTravel,
                        tujuanTravel: listtravelHistory[index].tujuanTravel,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      setState(() {
                        getTravelHistory();
                      });
                    }
                  });
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      child: Text(
                        listtravelHistory[index]
                            .kotaTujuan
                            .substring(0, 1)
                            .toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(listtravelHistory[index].kotaTujuan),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              deleteTravelHistory(listtravelHistory[index].id);
                              setState(() {
                                listtravelHistory.removeAt(index);
                              });

                              var snackBar = const SnackBar(
                                  content: Text('Data Berhasil Dihapus'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormPerjalanan()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
