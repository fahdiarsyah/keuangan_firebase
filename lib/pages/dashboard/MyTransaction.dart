import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keuangan_firebase/components/list_transaksi.dart';
import 'package:keuangan_firebase/components/styles.dart';
import 'package:keuangan_firebase/models/akun.dart';
import 'package:keuangan_firebase/models/transaksi.dart';

class MyTransaction extends StatefulWidget {
  final Akun akun;
  const MyTransaction({Key? key, required this.akun}) : super(key: key);

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<Transaksi> listTransaksi = [];

  @override
  void initState() {
    super.initState();
    getTransaksi();
  }

  void getTransaksi() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('transaksi')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .get();

      setState(() {
        listTransaksi.clear();
        for (var document in querySnapshot.docs) {
          var data = document.data();
          listTransaksi.add(
            Transaksi(
              uid: data['uid'],
              docId: data['docId'],
              namaTransaksi: data['namatransaksi'],
              tanggal: (data['tanggal'] as Timestamp).toDate(),
              nominal: data['nominal'],
              kategori: data['kategori'],
              nama: data['nama'],
              gambar: data['gambar'],
            ),
          );
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catatan Keuangan',
              style: headerStyle(level: 2, blue: true),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Anda Saat Ini',
                    style: headerStyle(level: 4, blue: false),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Rp.',
                    style: headerStyle(level: 3, blue: false),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1 / 1.234,
                ),
                itemCount: listTransaksi.length,
                itemBuilder: (context, index) {
                  if (listTransaksi.isEmpty) {
                    return Center(child: Text('Tidak ada laporan.'));
                  } else {
                    return ListTransaksi(
                      transaksi: listTransaksi[index],
                      akun: widget.akun,
                      isTransaksi: true,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
