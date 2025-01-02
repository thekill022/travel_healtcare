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
  bool isDeleting = false; // Untuk menunjukkan status penghapusan

  @override
  void initState() {
    super.initState();
    getTravelHistory(); // Mengambil data saat pertama kali dibuka
  }

  // Fungsi mengambil data
  void getTravelHistory() async {
    try {
      final travelhistory = await travelhistoryCtrl.getTravelHistory();
      setState(() {
        listtravelHistory = travelhistory;
      });
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Data Found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Fungsi menghapus data dan memperbarui daftar
  void deleteTravelHistory(int id) async {
    setState(() {
      isDeleting = true; // Aktifkan indikator loading
    });

    try {
      await travelhistoryCtrl.deleteTravelHistory(id); // Hapus data
      getTravelHistory(); // Perbarui data setelah dihapus
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Deleted Successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to Delete Data!'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isDeleting = false; // Matikan indikator loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            listtravelHistory.isEmpty // Jika kosong, tampilkan pesan
                ? const Center(child: Text('No Data Found.'))
                : ListView.builder(
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
                                  negaraTujuan:
                                      listtravelHistory[index].negaraTujuan,
                                  provinsiTujuan:
                                      listtravelHistory[index].provinsiTujuan,
                                  kotaTujuan:
                                      listtravelHistory[index].kotaTujuan,
                                  durasiTravel:
                                      listtravelHistory[index].durasiTravel,
                                  formattgl: listtravelHistory[index].formattgl,
                                  tujuanTravel:
                                      listtravelHistory[index].tujuanTravel,
                                ),
                              ),
                            ).then((value) {
                              if (value == true) {
                                getTravelHistory(); // Refresh setelah edit
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
                              title: Text(
                                  "${listtravelHistory[index].negaraTujuan} - ${listtravelHistory[index].provinsiTujuan}"),
                              subtitle:
                                  Text(listtravelHistory[index].formattgl),
                              trailing: IconButton(
                                onPressed: () {
                                  _showDeleteConfirmationDialog(context, index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            // Tampilkan indikator loading saat proses penghapusan
            if (isDeleting)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  // Konfirmasi penghapusan data
  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Do you want to delete this?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                deleteTravelHistory(listtravelHistory[index].id); // Hapus data
                setState(() {
                  listtravelHistory = [];
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
