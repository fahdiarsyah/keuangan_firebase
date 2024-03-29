import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keuangan_firebase/components/styles.dart';
import 'package:keuangan_firebase/models/akun.dart';

class Profile extends StatefulWidget {
  final Akun akun;
  const Profile({super.key, required this.akun});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;

  void keluar(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Container(
               width: double.infinity,
               margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
               child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    widget.akun.nama,
                    style: TextStyle(
                        color: accountColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  Text(
                    widget.akun.role,
                    style: TextStyle(
                        color: accountColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: blueColor),
                      ), // Sudut border
                    ),
                    child: Text(
                      widget.akun.noHP,
                      style: TextStyle(
                          color: youngBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: blueColor),
                      ), // Sudut border
                    ),
                    child: Text(
                      widget.akun.email,
                      style: TextStyle(
                          color: youngBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
    );
  }
}