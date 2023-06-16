import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './barang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './core/services/data.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';

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
  int cek_mode = 1;
  bool? mode = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> Thememode(int _mode) async {
    final SharedPreferences prefs = await _prefs;
    if (_mode == 1) {
      prefs.setBool('Lightmode', true);
      mode = prefs.getBool('Lightmode');
      cek_mode = 0;
    } else {
      prefs.setBool('Lightmode', false);
      mode = prefs.getBool('Lightmode');
      cek_mode = 1;
    }
  }

  final produk = FirebaseFirestore.instance.collection('produk').snapshots();
  final news = FirebaseFirestore.instance.collection('news').snapshots();

  final _bestProduk1 = FirebaseFirestore.instance
      .collection('produk')
      .orderBy("Terjual", descending: true)
      .limit(1)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      // doc.get("Terjual");
      // print(doc["Terjual"]);
    });
  });

  final _newArival = FirebaseFirestore.instance
      .collection('produk')
      .orderBy("ProdukID", descending: true)
      .limit(5)
      .snapshots();

  final _bestProduk2 = FirebaseFirestore.instance
      .collection('produk')
      .orderBy("Terjual", descending: true)
      .limit(1)
      .snapshots();

  void initState() {
    super.initState();
    print("initState() called");
    print(data.email);
    _prefs.then((SharedPreferences prefs) {
      return prefs.setBool('Lightmode', true);
    });
  }

  void cekFav(int x) {
    int fav = 0;
    bool cek = false;
    FirebaseFirestore.instance
        .collection('wishlist')
        .where("email", isEqualTo: data.email)
        .limit(1)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          for (int i = 0; i < docSnapshot.data()['Listwishlist'].length; i++) {
            if (docSnapshot.data()['Listwishlist'][i] == x) {
              cek = true;
              data.fav = 1;
              print('fav : ${data.fav}');
              print("fav");
              //return fav;
            }
            // else {
            //   data.fav = 0;
            // }
          }
        }
        if (data.login == false || cek == false) {
          data.fav = 0;
          print("Nofav : ${data.fav}");
          //return fav;
        }
        ;
      },
    );
    // return fav;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          cek_mode == 1 ? Color(0xFFF6F1F1) : Color.fromARGB(255, 38, 38, 38),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                IconButton(
                    //tombol wishlist
                    icon: Icon(
                      Icons.dark_mode,
                      color: cek_mode == 0
                          ? Color.fromARGB(255, 255, 221, 0)
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (cek_mode == 0) {
                        cek_mode = 1;
                        print('terang');
                      } else {
                        print('gelap');
                        cek_mode = 0;
                      }
                      // Thememode(cek_mode);
                    }),
                Center(
                  child: Text(
                    "News",
                    style: TextStyle(
                      color: cek_mode == 1
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: news,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final news_ = streamSnapshot.data!.docs;
                        return CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 150.0,
                            enlargeCenterPage:
                                true, // creating a feeling of depth in the carousel.(Menentukan apakah halaman saat ini harus lebih besar dari gambar samping,)
                            autoPlay:
                                true, //menggeser satu halaman pada satu waktu.
                            aspectRatio: 16 /
                                9, // Rasio aspek digunakan jika tidak ada ketinggian yang dinyatakan.
                            autoPlayCurve: Curves
                                .fastOutSlowIn, // Menentukan kurva animasi.
                            enableInfiniteScroll:
                                true, //Menentukan apakah carousel harus berputar tanpa batas atau terbatas pada panjang item.
                            autoPlayAnimationDuration: Duration(
                                milliseconds:
                                    800), // The animation duration between two transitioning pages while in auto playback.
                            viewportFraction:
                                0.8, // Bagian area pandang yang harus ditempati setiap halaman.
                          ),
                          itemCount: news_.length,
                          itemBuilder: (context, index, int k) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(documentSnapshot["gambar"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Best Product",
                    style: TextStyle(
                      color: cek_mode == 1
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: _bestProduk2,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final bestProduk = streamSnapshot.data!.docs;
                        return Card(
                          //best Product
                          clipBehavior: Clip
                              .hardEdge, //membuat clip rounded di ujung persegi
                          child: InkWell(
                            splashColor: Color(0xFF0E5E6F),
                            onTap: () {
                              data.produk = bestProduk[0]["ProdukID"];
                              // data.fav =
                              cekFav(bestProduk[0]["ProdukID"]);
                              print("test ${data.fav}");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return barang();
                                  },
                                ),
                              );
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        bestProduk[0]["NamaP"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Center(
                                      child: Image(
                                        image: NetworkImage(
                                            bestProduk[0]["image"]),
                                        width: 150,
                                        height: 130,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        "Rp." +
                                            bestProduk[0]["Harga"].toString(),
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
                                        Text(
                                            "Terjual " +
                                                bestProduk[0]["Terjual"]
                                                    .toString(),
                                            style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "New Arrivals",
                    style: TextStyle(
                      color: cek_mode == 1
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: _newArival,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final newArival = streamSnapshot.data!.docs;
                        return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              for (var i = 0; i < 5; i++) ...[
                                Card(
                                  //kotak 1
                                  clipBehavior: Clip
                                      .hardEdge, //membuat clip rounded di ujung persegi
                                  child: InkWell(
                                    splashColor: Color(0xFF0E5E6F),
                                    onTap: () {
                                      data.produk = newArival[i]["ProdukID"];
                                      // data.fav =
                                      cekFav(newArival[i]["ProdukID"]);
                                      print(data.fav);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 5, 0, 0),
                                              child: Text(
                                                newArival[i]["NamaP"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Center(
                                              child: Image(
                                                image: NetworkImage(
                                                    newArival[i]["image"]),
                                                width: 150,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                              child: Text(
                                                "Rp." +
                                                    newArival[i]["Harga"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.checkroom,
                                                          size: 15),
                                                      Text(
                                                        "S/M/L/XL",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    "Terjual " +
                                                        newArival[i]["Terjual"]
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                )
                              ]
                            ]));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Product",
                    style: TextStyle(
                      color: cek_mode == 1
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: produk,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final data3 = streamSnapshot.data!.docs;
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Card(
                                //kotak 1
                                clipBehavior: Clip
                                    .hardEdge, //membuat clip rounded di ujung persegi
                                child: InkWell(
                                  splashColor: Color(0xFF0E5E6F),
                                  onTap: () {
                                    data.produk = documentSnapshot["ProdukID"];
                                    // data.fav =
                                    cekFav(documentSnapshot["ProdukID"]);
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 0, 0),
                                            child: Text(
                                              documentSnapshot['NamaP'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Center(
                                            child: Image(
                                              image: NetworkImage(
                                                  documentSnapshot["image"]),
                                              width: 150,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Text(
                                              "Rp. " +
                                                  documentSnapshot['Harga']
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.checkroom,
                                                        size: 15),
                                                    Text(
                                                      "S/M/L/XL",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                  "terjual " +
                                                      documentSnapshot[
                                                              'Terjual']
                                                          .toString(),
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
