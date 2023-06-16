import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(const hd());
}

class hd extends StatelessWidget {
  const hd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'helpdesk',
      home: helpdesk(),
    );
  }
}

class helpdesk extends StatefulWidget {
  helpdesk({Key? key}) : super(key: key);
  @override
  State<helpdesk> createState() => _helpdeskState();
}

class _helpdeskState extends State<helpdesk> {
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF146C94),
          title: Text("helpdesk"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Helpdesk',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Subject Pesan'),
                      subtitle: TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan Subject Pesan',
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            16), // Memberikan jarak antara Subject Pesan dan Deskripsi Pesan
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        maxLines: 5, // Mengatur jumlah baris pada TextField
                        decoration: InputDecoration(
                          hintText: 'Masukkan Deskripsi Pesan',
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Logika untuk mengirim pesan
                          },
                          child: Text('Kirim'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
