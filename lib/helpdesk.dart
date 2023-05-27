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
  final CollectionReference _produk =
      FirebaseFirestore.instance.collection('produk');

  final TextEditingController _produkID = TextEditingController();
  final TextEditingController _KategoriID = TextEditingController();
  final TextEditingController _nameP = TextEditingController();
  final TextEditingController _detailP = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final TextEditingController _terjual = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("helpdesk"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _produkID,
                decoration: const InputDecoration(labelText: '_produkID'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _KategoriID,
                decoration: const InputDecoration(labelText: '_KategoriID'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _nameP,
                decoration: const InputDecoration(labelText: '_nameP'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _detailP,
                decoration: const InputDecoration(labelText: '_detailP'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _harga,
                decoration: const InputDecoration(labelText: '_harga'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _terjual,
                decoration: const InputDecoration(labelText: '_terjual'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Create'),
                onPressed: () async {
                  final String namap = _nameP.text;
                  final String detailp = _detailP.text;
                  final int? kategoriid = int.tryParse(_KategoriID.text);
                  final int? produkid = int.tryParse(_produkID.text);
                  final int? terjual = int.tryParse(_terjual.text);
                  final int? harga = int.tryParse(_harga.text);

                  await _produk.add({
                    "DetailP": detailp,
                    "Harga": harga,
                    "KategoriID": kategoriid,
                    "NamaP": namap,
                    "ProdukID": produkid,
                    "Terjual": terjual,
                  });

                  _nameP.text = '';
                  _detailP.text = '';
                  _KategoriID.text = '';
                  _produkID.text = '';
                  _terjual.text = '';
                  _harga.text = '';
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
