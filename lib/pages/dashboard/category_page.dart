import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories", style: GoogleFonts.montserrat(fontSize: 20),),
        backgroundColor: Color.fromARGB(255, 25, 86, 177),
      ),
      body: SafeArea(
        child: Column(
          children: [Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Switch(
                value: true, 
                onChanged: (bool value) {},
                inactiveThumbColor: Colors.green,
                inactiveTrackColor: Color.fromARGB(230, 105, 240, 123),
                activeColor: Colors.red,
              ),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.add),
              )],
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_upward, color: Colors.red,),
          )
          ],
        ),
      ),
    );
  }
}