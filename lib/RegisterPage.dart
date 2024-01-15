import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keuangan_firebase/components/input_widget.dart';
import 'package:keuangan_firebase/components/validators.dart';
import 'components/padding_teks.dart';
import 'components/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  bool _obscureText = true; // Untuk melihat teks (passwords)
  bool _obscureText2 = true;

  String? nama;
  String? email;
  String? noHP;

  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      CollectionReference akunCollection = _db.collection('akun');

      final password = _password.text;
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password);

      final docId = akunCollection.doc().id;
      await akunCollection.doc(docId).set({
        'uid': _auth.currentUser!.uid,
        'nama': nama,
        'email': email,
        'noHP': noHP,
        'docId': docId,
        'role': 'user',
      });

      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade800, Color.fromARGB(255, 110, 192, 230)],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 75),
                      PaddingTeks("CREATE"),
                      const SizedBox(height: 10),
                      PaddingTeks("ACCOUNT"),
                      const SizedBox(height: 50),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 55),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(75), bottomRight: Radius.circular(75)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: formRegister(context),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Form formRegister(BuildContext context) {
    return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // tempat inputan nanti
                              InputWidget(
                                  Icon(Icons.person),
                                  TextFormField(
                                      onChanged: (String value) => setState(() {
                                            nama = value;
                                          }),
                                      validator: notEmptyValidator,
                                      decoration: customInputDecoration(
                                          "Nama")),
                              ),
                              InputWidget(
                                  Icon(Icons.email),
                                  TextFormField(
                                      onChanged: (String value) => setState(() {
                                            email = value;
                                          }),
                                      validator: notEmptyValidator,
                                      decoration: customInputDecoration(
                                          "Email")),
                              ),
                              InputWidget(
                                  Icon(Icons.call),
                                  TextFormField(
                                      onChanged: (String value) => setState(() {
                                            noHP = value;
                                          }),
                                      validator: notEmptyValidator,
                                      decoration: customInputDecoration(
                                          "Phone Number")),
                              ),
                              InputWidget(
                                  Icon(Icons.lock_rounded),
                                  TextFormField(
                                      controller: _password,
                                      validator: notEmptyValidator,
                                      obscureText: _obscureText,
                                      decoration: customInputDecoration("Password").copyWith(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText ? Icons.visibility : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                  ),
                              ),
                              InputWidget(
                                  Icon(Icons.lock_rounded),
                                  TextFormField(
                                      validator: (value) =>
                                        passConfirmationValidator(
                                            value, _password),
                                      obscureText: _obscureText2,
                                      decoration: customInputDecoration("Confirm Password").copyWith(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText2 ? Icons.visibility : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText2 = !_obscureText2;
                                            });
                                          },
                                        ),
                                      ),
                                  ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 18),
                                width: double.infinity,
                                child: FilledButton(
                                    style: buttonStyle,
                                    child: Text('SIGN UP', style: headerStyle(level: 3, blue: false)),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        register();
                                      }
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text("or"),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: FilledButton(
                                    style: buttonStyle2,
                                    child: Text('LOGIN', style: headerStyle(level: 3)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    }),
                              ),
                            ]
                          ),
                      );
  }
}