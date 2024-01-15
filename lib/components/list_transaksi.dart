import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:keuangan_firebase/components/styles.dart';
import 'package:keuangan_firebase/models/akun.dart';
import 'package:keuangan_firebase/models/transaksi.dart';

class ListTransaksi extends StatefulWidget {
  final Transaksi transaksi;
  final Akun akun;
  final bool isTransaksi;
  const ListTransaksi(
      {super.key,
      required this.transaksi,
      required this.akun,
      required this.isTransaksi});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  void deleteTransaksi() async {
    try {
      // Menghapus dokumen laporan dari Firestore
      await _firestore.collection('transaksi').doc(widget.transaksi.docId).delete();
      
      // Menghapus gambar dari storage (jika gambar tidak kosong)
      if (widget.transaksi.gambar != '') {
        await _storage.refFromURL(widget.transaksi.gambar).delete();
      }

      // Kembali ke dashboard setelah berhasil menghapus
      Navigator.popAndPushNamed(context, '/dashboard');
    } catch (e) {
      // Handle error saat menghapus
      print('Error deleting report: $e');
    }
  }

   @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(width: 2))),
          child: Text(
            'Catatan Keuangan', // Gantilah dengan judul yang diinginkan
            style: titleStyle(level: 3),
          ),
        ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard', arguments: {
                  'transaksi': widget.transaksi,
                  'akun': widget.akun,
                });
              },
              onLongPress: () {
                if (widget.isTransaksi) {
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          title: Text('Delete ${widget.transaksi.namaTransaksi}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteTransaksi();
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        );
                      });
                }
              },
              child: Row(
              //   children: [
              //     widget.transaksi.gambar != ''
              //         ? Image.network(
              //             widget.transaksi.gambar!,
              //             width: 130,
              //             height: 130,
              //           )
              //         : Image.asset(
              //             'assets/photo-default.jpg',
              //             width: 130,
              //             height: 130,
              //           ),
              //     Container(
              //       width: double.infinity,
              //       alignment: Alignment.center,
              //       padding: const EdgeInsets.symmetric(vertical: 8),
              //       decoration: const BoxDecoration(
              //           border: Border.symmetric(horizontal: BorderSide(width: 2))),
              //       child: Text(
              //         widget.transaksi.namaTransaksi,
              //         style: titleStyle(level: 3),
              //       ),
              //     ),
              //     Container(
              //       height: 34,
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: Container(
              //               padding: const EdgeInsets.symmetric(vertical: 5),
              //               decoration: BoxDecoration(
              //                   color: warningColor,
              //                   borderRadius: const BorderRadius.only(
              //                     bottomLeft: Radius.circular(5),
              //                   ),
              //                   border: const Border.symmetric(
              //                       vertical: BorderSide(width: 1))),
              //               alignment: Alignment.center,
              //               child: Text(
              //                 DateFormat('dd/MM/yyyy').format(widget.transaksi.tanggal),
              //                 style: headerStyle(level: 5, blue: false),
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             child: Container(
              //               padding: const EdgeInsets.symmetric(vertical: 8),
              //               decoration: BoxDecoration(
              //                   color: primaryColor,
              //                   borderRadius: const BorderRadius.only(
              //                       bottomRight: Radius.circular(5)),
              //                   border: const Border.symmetric(
              //                       vertical: BorderSide(width: 1))),
              //               alignment: Alignment.center,
              //               child: Text(
              //                   '${widget.transaksi.nominal.toStringAsFixed(2)}',
              //                   style: titleStyle(level: 3),
              //               ),
              //           ),
              //         )
              //       ],
              //       ),
              //     )
              // ],
            ),
          )),
        ],
      );
    }
}