import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './barang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//test
void main() async {
  runApp(const hp());
}

class hp extends StatelessWidget {
  const hp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'homepage',
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  homepage({Key? key}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _bestProduk1 = FirebaseFirestore.instance
      .collection('produk')
      .orderBy("Terjual", descending: true)
      .limit(1)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.get("Terjual");
      print(doc["Terjual"]);
    });
  });

  final CollectionReference _bestProduk =
      FirebaseFirestore.instance.collection('produk');

  int? qty;

  final _bestProduk2 = FirebaseFirestore.instance
      .collection('produk')
      .orderBy("Terjual", descending: true)
      .limit(1)
      .get();

  void initState() {
    super.initState();
    print("initState() called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "News",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                CarouselSlider(
                  items: [
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('aset/Banner1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('aset/banner2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('aset/banner3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 150.0,
                    enlargeCenterPage:
                        true, // creating a feeling of depth in the carousel.(Menentukan apakah halaman saat ini harus lebih besar dari gambar samping,)
                    autoPlay: true, //menggeser satu halaman pada satu waktu.
                    aspectRatio: 16 /
                        9, // Rasio aspek digunakan jika tidak ada ketinggian yang dinyatakan.
                    autoPlayCurve:
                        Curves.fastOutSlowIn, // Menentukan kurva animasi.
                    enableInfiniteScroll:
                        true, //Menentukan apakah carousel harus berputar tanpa batas atau terbatas pada panjang item.
                    autoPlayAnimationDuration: Duration(
                        milliseconds:
                            800), // The animation duration between two transitioning pages while in auto playback.
                    viewportFraction:
                        0.8, // Bagian area pandang yang harus ditempati setiap halaman.
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Best Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Card(
                  //best Product
                  clipBehavior:
                      Clip.hardEdge, //membuat clip rounded di ujung persegi
                  child: InkWell(
                    splashColor: Color(0xFF0E5E6F),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            FirebaseFirestore.instance
                                .collection('produk')
                                .orderBy("Terjual", descending: true)
                                .limit(1)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                print(doc["Terjual"]);
                              });
                            });
                            return barang();
                          },
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                              child: Text(
                                "Anorak Jacket",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Center(
                              child: Image(
                                image: NetworkImage(
                                    'https://cdn.shopify.com/s/files/1/0607/2841/0296/products/BOMBERZWOLEDARKOAK.jpg?v=1677251536'),
                                width: 150,
                                height: 130,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                "Rp100.000",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.checkroom, size: 15),
                                      Text(
                                        "S/M/L/XL",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(qty.toString(),
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "New Arrivals",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < 5; i++) ...[
                        Card(
                          //kotak 1
                          clipBehavior: Clip
                              .hardEdge, //membuat clip rounded di ujung persegi
                          child: InkWell(
                            splashColor: Color(0xFF0E5E6F),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return barang();
                                  },
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 180,
                              height: 170,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        "Anorak Jacket",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Center(
                                      child: Image(
                                        image: AssetImage(
                                            'aset/Anorak_Jacket.jpg'),
                                        width: 150,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        "Rp100.000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.checkroom, size: 15),
                                              Text(
                                                "S/M/L/XL",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text("10RB+ terjual",
                                            style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                for (var i = 0; i < 5; i++) ...[
                  //loop
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        //kotak 1
                        clipBehavior: Clip
                            .hardEdge, //membuat clip rounded di ujung persegi
                        child: InkWell(
                          splashColor: Color(0xFF0E5E6F),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return barang();
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 180,
                            height: 170,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text(
                                      "Anorak Jacket",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Center(
                                    child: Image(
                                      image:
                                          AssetImage('aset/Anorak_Jacket.jpg'),
                                      width: 150,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      "Rp100.000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.checkroom, size: 15),
                                            Text(
                                              "S/M/L/XL",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text("10RB+ terjual",
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Card(
                        //kotak 2
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Color(0xFF0E5E6F),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return barang();
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 180,
                            height: 170,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text(
                                      "Anorak Jacket",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Center(
                                    child: Image(
                                      image:
                                          AssetImage('aset/Anorak_Jacket.jpg'),
                                      width: 150,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      "Rp100.000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.checkroom, size: 15),
                                            Text(
                                              "S/M/L/XL",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text("10RB+ terjual",
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
