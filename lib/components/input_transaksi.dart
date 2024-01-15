import 'package:flutter/material.dart';

class InputTransaksi extends StatelessWidget {
  final Icon? icon;
  final StatefulWidget inputField;

  InputTransaksi(
    this.inputField, {
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [ // Jarak antara ikon dan input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Warna border
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: inputField,
                    ),
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 10), // Jarak antara ikon dan input
                    ],
                  ]
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

InputDecoration customeDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Atur warna border bawah
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue), // Atur warna border bawah saat fokus
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  );
}