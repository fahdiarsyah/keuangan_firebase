import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_firebase/components/input_transaksi.dart';
import 'package:keuangan_firebase/components/styles.dart';
import 'package:keuangan_firebase/components/validators.dart';
import 'package:keuangan_firebase/components/vars.dart';
import 'package:keuangan_firebase/models/akun.dart';
import 'package:file_picker/file_picker.dart';


class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<StatefulWidget> createState() => AddTransactionState();
}

class AddTransactionState extends State<AddTransaction> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  bool _isLoading = false;

  String? namaTransaksi;
  DateTime? tanggal;
  String? kategori;
  double? nominal;
  String? keterangan;
  String? gambar;

  ImagePicker picker = ImagePicker();
  XFile? file;

  IconButton buildFilePickerButton() {
    return IconButton(
      icon: Icon(Icons.attach_file, color: blueColor),
      onPressed: () async {
        await uploadDialog(context);
      },
    );
  }

  Future _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != tanggal) {
      setState(() {
        tanggal = pickedDate;
      });
    }
  }

  Image imagePreview() {
    if (file == null) {
      return Image.asset('assets/default.jpg', width: 0, height: 0);
    } else {
      return Image.file(File(file!.path), width: 180, height: 180);
    }
  }

  // Pop-up upload Photo
  Future<dynamic> uploadDialog(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: true,
      );

      if (result != null) {
        setState(() {
          file = XFile(result.files.first.path!);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: const Text('Pilih sumber '),
            actions: [
              TextButton(
                onPressed: () async {
                  XFile? upload =
                      await picker.pickImage(source: ImageSource.camera);

                  setState(() {
                    file = upload;
                  });

                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.camera_alt),
              ),
              TextButton(
                onPressed: () async {
                  XFile? upload =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    file = upload;
                  });
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.photo_library),
              ),
            ],
          );
        });
  }

  // Upload Photo to Firebase
  Future<String?> uploadImage() async {
    if (file == null) return null;

    String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      Reference dirUpload =
          _storage.ref().child('upload/${_auth.currentUser!.uid}');
      Reference storedDir = dirUpload.child(uniqueFilename);

      await storedDir.putFile(File(file!.path));

      String downloadURL = await storedDir.getDownloadURL();
      print('Download URL: $downloadURL');

    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
  
  void addTransaksi(Akun akun) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (namaTransaksi == null) {
        throw 'Nama Transaksi tidak boleh kosong';
      }
      CollectionReference transaksiCollection = _firestore.collection('transaksi');

      String? url = await uploadImage();

      final id = transaksiCollection.doc().id;

      await transaksiCollection.doc(id).set({
        'uid': _auth.currentUser!.uid,
        'docId': id,
        'namatransaksi': namaTransaksi,
        'nominal': nominal,
        'kategori': kategori,
        'keterangan': keterangan,
        'gambar': url,
        'nama': akun.nama,
        'tanggal': tanggal,
      }).catchError((e) {
        throw e;
      });
      Navigator.popAndPushNamed(context, '/dashboard');
    } catch (e) {
      print('Error: $e');
      final snackbar = SnackBar(content: Text('Terjadi kesalahan: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Akun akun = arguments['akun'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blueColor,
          title:
              Text('Tambah Transaksi', style: titleStyle(level: 3, dark: false)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Form(
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text(
                            "Transaksi Baru",
                            style: titleStyle(level: 2,dark: true),
                          ),
                          const SizedBox(height: 30),
                          InputTransaksi(
                              TextFormField(
                                  onChanged: (String value) => setState(() {
                                    namaTransaksi = value;
                                  }),
                                  validator: notEmptyValidator,
                                  decoration: customeDecoration("Nama Transaksi"))),
                          InputTransaksi(
                            TextFormField(
                              readOnly: true,
                              onTap: () async {
                                await _selectDate(context);
                              },
                              decoration: customeDecoration('Tanggal Transaksi'),
                              controller: TextEditingController(
                                  text: tanggal != null
                                      ? DateFormat('dd/MM/yyyy').format(tanggal!)
                                      : ''),
                            ),
                            icon: Icon(Icons.date_range, color: blueColor),
                          ),
                          InputTransaksi(
                            TextFormField(
                              onChanged: (String value) => setState(() {
                                nominal = double.tryParse(value) ?? 0.0;
                              }),
                              validator: validateNominal,
                              keyboardType: TextInputType.number,
                              decoration: customeDecoration("Nominal"),
                            ),
                            icon: Icon(Icons.attach_money, color: blueColor),
                          ),
                          InputTransaksi(
                              DropdownButtonFormField<String>(
                                  decoration: customeDecoration('Kategori'),
                                  items: dataKategori.map((e) {
                                    return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e));
                                  }).toList(),
                                  onChanged: (selected) {
                                    setState(() {
                                      kategori = selected;
                                    });
                                  })),
                          InputTransaksi(
                            TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: file == null ? 'Tambah File' : file!.name),
                              style: TextStyle(
                                color: file == null ? Colors.black : Colors.blue,
                              ),
                              decoration: customeDecoration('Tambah File'),
                              onTap: () async {
                                await uploadDialog(context);
                              },
                            ),
                            icon: Icon(Icons.add, color: blueColor),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: imagePreview(),
                          ),
                          // InputPicker(
                          //   child: TextField(
                          //     enabled: false, // Tidak bisa diedit
                          //     controller: TextEditingController(
                          //         text: file == null ? 'Tambah File' : file!.name),
                          //     style: TextStyle(
                          //       color: file == null ? Colors.black : Colors.blue,
                          //     ),
                          //     decoration: customeDecoration('Tambah File'),
                          //   ),
                          //   icon: IconButton(
                          //     icon: Icon(Icons.add),
                          //     onPressed: () async {
                          //       await uploadDialog(context);
                          //     },
                          //   ),
                          // ),
                          InputTransaksi(
                              TextFormField(
                                onChanged: (String value) => setState(() {
                                  keterangan = value;
                                }),
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: 6,
                                decoration: customeDecoration(
                                    'Keterangan'),
                              )),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                                child: Text(
                                    'Tambah Transaksi',
                                    style: headerStyle(level: 3, blue: false),
                                  ),
                                style: buttonStyle,
                                  onPressed: () {
                                  addTransaksi(akun);
                                }),  
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      );
  }
}