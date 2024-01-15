import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keuangan_firebase/components/styles.dart';
import 'package:keuangan_firebase/models/akun.dart';
import 'package:keuangan_firebase/models/transaksi.dart';
import 'package:keuangan_firebase/pages/dashboard/MyTransaction.dart';
import 'package:keuangan_firebase/pages/dashboard/ProfilePage.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardFull();
  }
}

class DashboardFull extends StatefulWidget {
  const DashboardFull({super.key});

  
  @override
  State<StatefulWidget> createState() => _DashboardFull();
}

class _DashboardFull extends State<DashboardFull> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  List<Transaksi> transaksiList = [];
  
  Akun akun = Akun(
    uid: '',
    docId: '',
    nama: '',
    noHP: '',
    email: '',
    role: '',
  );

  void keluar(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  Future<void> showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Dialog tidak dapat ditutup dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin ingin keluar?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                keluar(context); // Panggil fungsi keluar jika pengguna menekan "Keluar"
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }


  void getAkun() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('akun')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();

        setState(() {
          akun = Akun(
            uid: userData['uid'],
            nama: userData['nama'],
            noHP: userData['noHP'],
            email: userData['email'],
            docId: userData['docId'],
            role: userData['role'],
          );
        });
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  int _selectedIndex = 0;
  List<Widget> pages = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getAkun();
  }

  @override
  Widget build(BuildContext context) {
    pages = <Widget>[
      MyTransaction(akun: akun),
      Profile(akun: akun,)
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: whiteColor,
          child: const Icon(
            Icons.add,
            size: 35,
            color: Color.fromARGB(255, 43, 168, 199),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/add', arguments: {
              'akun': akun,
            });
          },
          shape: CircleBorder(
            side: BorderSide(color: Color.fromARGB(255, 43, 168, 199), width: 0.9),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/default.jpg'),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              Text(
                'Hallo, ',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              Text(
                akun.nama,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ],
          ),
          actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black,),
            onPressed: () {
              showExitConfirmationDialog(context);
            },
          ),
        ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: youngBlue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        selectedFontSize: 16,
        unselectedItemColor: Colors.grey[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Transaction Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Category Page',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pages.elementAt(_selectedIndex),
    );
              
          

  }
}