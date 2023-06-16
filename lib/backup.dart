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

// ListView(
//           children: [
//             Container(
//               width: 500.0,
//               height: 500.0,
//               decoration: BoxDecoration(
//                 image: const DecorationImage(
//                   image: AssetImage('aset/Anorak_Jacket.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20), // Jarak antara gambar dan teks
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 20.0),
//                 child: Text(
//                   'Anorak Jacket',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10), // Jarak antara teks
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 20.0),
//                 child: Text(
//                   'Rp 100.000',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w100,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Row(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedSize = 'S';
//                         });
//                       },
//                       child: const Text(
//                         'S',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.white,
//                         onPrimary: const Color(0xff146C94),
//                         side: const BorderSide(
//                           color: const Color(0xff146C94),
//                           width: 1.0,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0,
//                           vertical: 10.0,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedSize = 'M';
//                         });
//                       },
//                       child: const Text(
//                         'M',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: const Color(0xff146C94),
//                         onPrimary: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0,
//                           vertical: 10.0,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedSize = 'L';
//                         });
//                       },
//                       child: const Text(
//                         'L',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: const Color(0xff146C94),
//                         onPrimary: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0,
//                           vertical: 10.0,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedSize = 'XL';
//                         });
//                       },
//                       child: const Text(
//                         'XL',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: const Color(0xff146C94),
//                         onPrimary: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0,
//                           vertical: 10.0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Deskripsi Produk',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Text(
//                       'Kemeja pria model terbaru dengan bahan yang berkualitas tinggi dan nyaman digunakan. Terdapat banyak pilihan warna dan ukuran yang bisa dipilih sesuai selera.Berbahan Katun',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w300,
//                       ),
//                       maxLines: _isExpanded ? null : 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 10.0),
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           _isExpanded = !_isExpanded;
//                         });
//                       },
//                       child: Text(
//                         _isExpanded ? 'See less' : 'See more',
//                         style: const TextStyle(
//                           fontSize: 16.0,
//                           color: Color(0xff146C94),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),

