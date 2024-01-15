import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashFull();
  }
}

class SplashFull extends StatefulWidget {
  const SplashFull({super.key});

  @override 
  State<StatefulWidget> createState() => _SplashPage();
}


class _SplashPage extends State<SplashFull> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    
    User? user = _auth.currentUser;

    if (user != null) {
      Future.delayed(Duration.zero, () {
      // buat dashboard terlebih dahulu, lalu hapus komen line code dibawah ini 
      Navigator.pushReplacementNamed(context, '/dashboard');
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Center(
        child: Text('Selamat datang di Aplikasi Laporan Keuangan'),
      ),
    ));
  }
}

//   bool _isLoading = false;
//   int _selectedIndex = 0;
//   List<Widget> pages = [];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     pages = <Widget>[
//       HomePage(),
//       CategoryPage(),
//     ];
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color.fromARGB(255, 1, 133, 5),
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color.fromARGB(255, 164, 209, 166),
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.black,
//         selectedFontSize: 16,
//         unselectedItemColor: Colors.grey[800],
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home Page',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_sharp),
//             label: 'Category Page',
//           ),
//         ]),
//         body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : pages.elementAt(_selectedIndex),
//     );
//   }
// }