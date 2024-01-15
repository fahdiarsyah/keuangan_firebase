import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/input_widget.dart';
import 'components/padding_teks.dart';
import 'components/styles.dart';
import 'components/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool _obscureText = true; // Untuk melihat teks (passwords)

  String? email;
  String? password;

  void login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      Navigator.pushNamedAndRemoveUntil(
          context, '/dashboard', ModalRoute.withName('/dashboard'));
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                      PaddingTeks("WELCOME"),
                      const SizedBox(height: 10),
                      PaddingTeks("BACK"),
                      const SizedBox(height: 190),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // tempat inputan nanti
                                InputWidget(
                                    Icon(Icons.email),
                                    TextFormField(
                                        onChanged: (String value) => setState(() {
                                              email = value;
                                            }),
                                        validator: notEmptyValidator,
                                        decoration: customInputDecoration(
                                            "Email"))),
                                InputWidget(
                                    Icon(Icons.lock_rounded),
                                    TextFormField(
                                        onChanged: (String value) => setState(() {
                                              password = value;
                                            }),
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
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  child: FilledButton(
                                      style: buttonStyle,
                                      child: Text('LOGIN',
                                          style:
                                              headerStyle(level: 3, blue: false)),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          login();
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
                                      child: Text("or",),
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
                                    child: Text('SIGN UP', style: headerStyle(level: 3)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/register');
                                    }),
                              ),
                              ],
                            )),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}