import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './core/services/data.dart' as data;

void main() async {
  runApp(const ps());
}

class ps extends StatelessWidget {
  const ps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pesanan',
      home: pesanan(),
    );
  }
}

class pesanan extends StatefulWidget {
  pesanan({Key? key}) : super(key: key);
  @override
  State<pesanan> createState() => _pesananpageState();
}

class _pesananpageState extends State<pesanan> {
  final DTpesanan = FirebaseFirestore.instance
      .collection('pesanan')
      .where("email", isEqualTo: data.email)
      .limit(1)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("Riwayat Pemesanan"),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(5),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Riwayat Pemesanan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            StreamBuilder(
                stream: DTpesanan,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final items = streamSnapshot.data!.docs;
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[0];
                    return ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(16),
                        children: [
                          for (int i = items[0]['Lpesanan'].length - 1;
                              i >= 0;
                              i--) ...[
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('produk')
                                    .where("ProdukID",
                                        isEqualTo: items[0]['Lpesanan'][i]
                                            ['productID'])
                                    .limit(1)
                                    .snapshots(), //mengambil data produk berdasarkan produk fav (Listwishlist)
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot>
                                        streamSnapshot) {
                                  if (streamSnapshot.hasData) {
                                    final item = streamSnapshot.data!.docs;
                                    return Card(
                                        child: SizedBox(
                                      width: 150,
                                      height: 120,
                                      child: Column(children: [
                                        Row(children: [
                                          Image(
                                            image:
                                                NetworkImage(item[0]["image"]),
                                            width: 150,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item[0]['NamaP'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "Rp." +
                                                    item[0]['Harga'].toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "Size : " +
                                                    items[0]['Lpesanan'][i]
                                                        ['size'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "Quantity : " +
                                                    items[0]['Lpesanan'][i]
                                                            ['qty']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "Kode Resi : " +
                                                    items[0]['Lpesanan'][i]
                                                            ['kodeResi']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ]),
                                    ));
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                })
                          ]
                        ]);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
