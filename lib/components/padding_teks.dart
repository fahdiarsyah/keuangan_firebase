import 'package:flutter/material.dart';
import 'package:keuangan_firebase/components/styles.dart';

class PaddingTeks extends StatelessWidget {
  final String teksJudul;

  PaddingTeks(
    this.teksJudul, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(teksJudul, style: titleStyle(level:1)),
    );
  }
}