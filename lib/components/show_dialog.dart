// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:keuangan_firebase/components/styles.dart';
// import 'package:keuangan_firebase/models/transaksi.dart';

// class StatusDialog extends StatefulWidget {
//   final Transaksi transaksi;

//   const StatusDialog({super.key, 
//     required this.transaksi,
//   });

//   @override
//   _StatusDialogState createState() => _StatusDialogState();
// }

// class _StatusDialogState extends State<StatusDialog> {
//   late String namaTransaksi;
//   final _firestore = FirebaseFirestore.instance;

//   void updateStatus() async {
//     CollectionReference transaksiCollection = _firestore.collection('laporan');
//     try {
//       await transaksiCollection.doc(widget.transaksi.docId).update({
//         'namatransaksi': namaTransaksi,
//       });
//       Navigator.popAndPushNamed(context, '/dashboard');
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     namaTransaksi = widget.transaksi.namaTransaksi;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: warningColor,
//       contentPadding: EdgeInsets.all(11),
//       content: Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text(
//               widget.laporan.judul,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             RadioListTile<String>(
//               title: const Text('Posted'),
//               value: 'Posted',
//               groupValue: status,
//               onChanged: (value) {
//                 setState(() {
//                   status = value!;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Process'),
//               value: 'Process',
//               groupValue: status,
//               onChanged: (value) {
//                 setState(() {
//                   status = value!;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Done'),
//               value: 'Done',
//               groupValue: status,
//               onChanged: (value) {
//                 setState(() {
//                   status = value!;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 print(status);
//                 updateStatus();
//               },
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.black,
//                 backgroundColor: warningColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Text('Simpan Status'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }