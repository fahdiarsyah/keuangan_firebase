import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final Icon icon;
  final StatefulWidget inputField;

  InputWidget(
    this.icon,
    this.inputField, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon, // Menampilkan widget Icon
            const SizedBox(width: 10), // Jarak antara ikon dan input
            Expanded(
              child: Container(
                child: inputField,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

InputDecoration customInputDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Atur warna border bawah
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue), // Atur warna border bawah saat fokus
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  );
}