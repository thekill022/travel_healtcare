import 'package:flutter/material.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';
import 'package:travel_healthcare/views/perjalanan/edit_form_perjalanan.dart';

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
    try {
      final travelhistory = await travelhistoryCtrl.getTravelHistory();
      setState(() {
        listtravelHistory = travelhistory;
      });
    } catch (e) {
      // Handle error and show a message
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak ada data perjalanan'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
        child: FutureBuilder(
          future: travelhistoryCtrl.getTravelHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Future.delayed(Duration.zero, () {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => LoginPage()));
              // });

              return const Center(
                child: Text('Belum ada data riwayat perjalanan'),
              );
            } else {
              listtravelHistory = snapshot.data as List<TravelHistoryModel>;

              if (listtravelHistory.isEmpty) {
                // Display a message or widget when travel history is empty
                return const Center(
                  child: Text('Belum ada data riwayat perjalanan.'),
                );
              }

              return ListView.builder(
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
                              provinsiTujuan:
                                  listtravelHistory[index].provinsiTujuan,
                              durasiTravel:
                                  listtravelHistory[index].durasiTravel,
                              formattgl: listtravelHistory[index].formattgl,
                              tujuanTravel:
                                  listtravelHistory[index].tujuanTravel,
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
                            backgroundColor:
                                const Color.fromARGB(255, 81, 134, 177),
                            child: Text(
                              listtravelHistory[index]
                                  .kotaTujuan
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(listtravelHistory[index].kotaTujuan),
                          subtitle: Text(listtravelHistory[index].formattgl),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  _showDeleteConfirmationDialog(context, index);
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Delete Confirmation'),
          content: Text('Apakah anda ingin menghapus ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Call the delete function here
                deleteTravelHistory(listtravelHistory[index].id);
                setState(() {
                  listtravelHistory.removeAt(index);
                  getTravelHistory();
                });

                var snackBar =
                    const SnackBar(content: Text('Data Berhasil Dihapus'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
