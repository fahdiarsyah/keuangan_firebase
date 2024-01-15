import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keuangan_firebase/models/transaksi.dart';

class TransaksiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> calculateTotal({required String uid, required String kategori}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('transaksi')
          .where('uid', isEqualTo: uid)
          .where('kategori', isEqualTo: kategori)
          .get();

      double total = 0.0;

      querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        Transaksi transaksi = Transaksi(
          uid: document['uid'],
          docId: document['docId'],
          namaTransaksi: document['namaTransaksi'],
          tanggal: (document['tanggal'] as Timestamp).toDate(),
          nominal: document['nominal'].toDouble(),
          kategori: document['kategori'],
          gambar: document['gambar'],
          nama: document['nama'],
        );

        if (kategori == 'Income') {
          total += transaksi.nominal;
        } else if (kategori == 'Expense') {
          total -= transaksi.nominal;
        }
      });

      return total;
    } catch (e) {
      print('Error calculating total: $e');
      return 0.0;
    }
  }
}
