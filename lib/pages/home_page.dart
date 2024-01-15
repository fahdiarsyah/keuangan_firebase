import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        accent: Color.fromARGB(238, 10, 155, 14),
        backButton: false,
        locale: 'id',
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dashboard(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Transaksi", style: GoogleFonts.montserrat(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 10),
                        Icon(Icons.edit)
                      ],
                    ),
                    title: Text("Rp. 20.000,-"),
                    subtitle: Text("Ngopi"),
                    leading: Container(
                              child: Icon(Icons.arrow_downward, color: Colors.red,),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 10),
                        Icon(Icons.edit)
                      ],
                    ),
                    title: Text("Rp. 8.000.000,-"),
                    subtitle: Text("Gaji Bulanan"),
                    leading: Container(
                              child: Icon(Icons.arrow_upward, color: Colors.green,),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding dashboard() {
    return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.arrow_downward, color: Colors.green,),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Income", style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 12
                          )),
                          SizedBox(height: 8),
                          Text("Rp. 2.501.000,-", style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 14
                          )),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.arrow_upward, color: Colors.red,),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Expense", style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 12
                          )),
                          SizedBox(height: 8),
                          Text("Rp. 1.000.000,-", style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 14
                          )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
  }
}