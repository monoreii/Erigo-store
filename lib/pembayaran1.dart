import 'package:flutter/material.dart';
import './main.dart';
import './core/services/cartList.dart' as cartList;
import 'package:cloud_firestore/cloud_firestore.dart';
import './core/services/data.dart' as data;
import 'dart:math';

void main() async {
  runApp(const pb1());
}

class pb1 extends StatelessWidget {
  const pb1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pembayaran1',
      home: Pembayaran1(),
    );
  }
}

class Pembayaran1 extends StatefulWidget {
  const Pembayaran1({super.key});

  @override
  State<Pembayaran1> createState() => _Pembayaran1();
}

class _Pembayaran1 extends State<Pembayaran1> {
  int kodeResi = 100000 + Random().nextInt(1000000 - 100000);
  // Initial Selected Value
  String mtdPengiriman = 'Reguler';
  final TextEditingController controlAP = TextEditingController();
  final TextEditingController controlKP = TextEditingController();
  final TextEditingController controlCP = TextEditingController();

  final DTproduk = FirebaseFirestore.instance
      .collection('produk')
      .where("ProdukID", isEqualTo: data.produk)
      .limit(1)
      .snapshots();

  final DTakun = FirebaseFirestore.instance
      .collection('akun')
      .where("email", isEqualTo: data.email)
      .limit(1)
      .snapshots();

  // List of items in our dropdown menu
  var listPengiriman = [
    'Reguler',
    'Premium',
  ];

  // Initial Selected Value
  String logoPembayaran = 'aset/Mandiri.png';
  String mtdPembayaran = 'Mandiri';
  String noRek = '1111111111111';

  // List of items in our dropdown menu
  var listPembayaran = [
    'Mandiri',
    'BCA',
    'BRI',
    'BNI',
  ];

  void FlogoPembayaran() {
    switch (mtdPembayaran) {
      case 'Mandiri':
        logoPembayaran = 'aset/Mandiri.png';
        noRek = '1111111111111';
        break;
      case 'BCA':
        logoPembayaran = 'aset/BCA.png';
        noRek = '2222222222222';
        break;
      case 'BRI':
        logoPembayaran = 'aset/BRI.png';
        noRek = '3333333333333';
        break;
      case 'BNI':
        logoPembayaran = 'aset/BNI.png';
        noRek = '4444444444444';
        break;
    }
  }

  String code = '';
  int biaya = 0;
  int Bpengiriman() {
    String temp = controlKP.text;
    if (temp != "") {
      List<String> Listcode = temp.split('');
      code = Listcode[0];
      switch (mtdPengiriman) {
        case 'Reguler':
          switch (code) {
            case "1":
              biaya = 10000;
              break;
            case "2":
              biaya = 20000;
              break;
            case "3":
              biaya = 22000;
              break;
            case "4":
              biaya = 13000;
              break;
            case "5":
              biaya = 15000;
              break;
            case "6":
              biaya = 17000;
              break;
            case "7":
              biaya = 25000;
              break;
            case "8":
              biaya = 22000;
              break;
            case "9":
              biaya = 28000;
              break;
          }
          break;
        case 'Premium':
          switch (code) {
            case "1":
              biaya = 15000;
              break;
            case "2":
              biaya = 25000;
              break;
            case "3":
              biaya = 27000;
              break;
            case "4":
              biaya = 18000;
              break;
            case "5":
              biaya = 20000;
              break;
            case "6":
              biaya = 23000;
              break;
            case "7":
              biaya = 30000;
              break;
            case "8":
              biaya = 27000;
              break;
            case "9":
              biaya = 33000;
              break;
          }
          break;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Kode Pos mohon diisi')));
    }
    return biaya;
  }

  final CollectionReference _pesanan =
      FirebaseFirestore.instance.collection('pesanan');

  void plusPesanan(int idProduk, int harga) {
    FirebaseFirestore.instance
        .collection('pesanan')
        .where("email", isEqualTo: data.email)
        .limit(1)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Map<dynamic, dynamic> produk = {
          "productID": idProduk,
          "qty": 1,
          "size": 'L',
          "Harga": harga,
          "kodeResi": kodeResi
        };
        _pesanan.doc(docSnapshot.id).update({
          "email": docSnapshot.data()['email'],
          "Lpesanan": FieldValue.arrayUnion([produk])
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF146C94),
          title: Text("Pembayaran"),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: DTproduk,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final produk = streamSnapshot.data!.docs;
                        return ListView(children: [
                          Card(
                              child: SizedBox(
                            width: 150,
                            height: 120,
                            child: Column(children: [
                              Row(children: [
                                Image(
                                  image: NetworkImage(produk[0]["image"]),
                                  width: 150,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      produk[0]['NamaP'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Rp." + produk[0]['Harga'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "Size : " + data.size,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "Quantity : 1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]),
                            ]),
                          )),
                          StreamBuilder(
                              stream: DTakun,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  final akun = streamSnapshot.data!.docs;
                                  controlAP.text = akun[0]['alamat'];
                                  controlKP.text = akun[0]['kodePos'];
                                  return Card(
                                    child: SizedBox(
                                      width: 150,
                                      height: 500,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Alamat pengiriman",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextField(
                                            enabled: false,
                                            controller: controlAP,
                                            maxLines: 4,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Alamat pengiriman',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextField(
                                            enabled: false,
                                            controller: controlKP,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Kode Pos',
                                            ),
                                            onSubmitted: (inputValue) {
                                              Bpengiriman();
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.local_shipping),
                                              Text(" Jenis pengiriman $code",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              DropdownButton(
                                                // Initial Value
                                                value: mtdPengiriman,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),

                                                // Array list of items
                                                items: listPengiriman
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    mtdPengiriman = newValue!;
                                                    Bpengiriman();
                                                  });
                                                },
                                              ),
                                              Text("Rp." +
                                                  Bpengiriman().toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Metode Pembayaran",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextField(
                                            controller: controlCP,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Kode Promo',
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              DropdownButton(
                                                // Initial Value
                                                value: mtdPembayaran,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),

                                                // Array list of items
                                                items: listPembayaran
                                                    .map((String items1) {
                                                  return DropdownMenuItem(
                                                    value: items1,
                                                    child: Text(items1),
                                                  );
                                                }).toList(),
                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (String? newValue1) {
                                                  setState(() {
                                                    mtdPembayaran = newValue1!;
                                                    FlogoPembayaran();
                                                  });
                                                },
                                              ),
                                              Image(
                                                image:
                                                    AssetImage(logoPembayaran),
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.contain,
                                              ),
                                            ],
                                          ),
                                          Text("Nomor Rekening : " + noRek),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ]);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }))),
        floatingActionButton: StreamBuilder(
            stream: DTproduk,
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                final harga = streamSnapshot.data!.docs;
                return FloatingActionButton.extended(
                  onPressed: () {
                    plusPesanan(harga[0]['ProdukID'], harga[0]['Harga']);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Pembayaran berhasil'),
                        content: Text(
                            'Terima kasih sudah berbelanja di toko kami\n' +
                                "Kode resi : " +
                                kodeResi.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MyApp();
                                  },
                                ),
                              );
                            },
                            child: const Text('Lanjut berbelanja'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.payments),
                  label: Text("Rp." + (harga[0]['Harga'] + biaya).toString()),
                  backgroundColor: Color(0xFF146C94),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
