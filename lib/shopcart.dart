import 'package:flutter/material.dart';
import './pembayaran.dart';
import './core/services/cartList.dart' as cartList;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './core/services/data.dart' as data;
import './barang.dart';

void main() async {
  runApp(const sc());
}

class sc extends StatelessWidget {
  const sc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopCart',
      home: shopcart(),
    );
  }
}

class shopcart extends StatefulWidget {
  shopcart({Key? key}) : super(key: key);
  @override
  State<shopcart> createState() => _shopcartState();
}

class _shopcartState extends State<shopcart> {
  num harga = 0;
  int _counter = cartList.qty;
  int _selectedIndex = 1;
  num total = cartList.hargaAwal;

  //firebase

// Initial Selected Value
  String _selectedSize = 'L';

  void Csize(DocumentSnapshot? documentSnapshot, int x, String y) {
    if (documentSnapshot != null) {
      String email = documentSnapshot['email'];
      int productID = documentSnapshot['ListShopcart'][x]['productID'];
      String size = y;
      int qty = documentSnapshot['ListShopcart'][x]['qty'];
      String Lsize = documentSnapshot['ListShopcart'][x]['size'];
      int hargaP = documentSnapshot['ListShopcart'][x]['Harga'];
      Map<dynamic, dynamic> produk1 = {
        "productID": productID,
        "qty": qty,
        "size": Lsize,
        "Harga": hargaP
      };
      Map<dynamic, dynamic> produk = {
        "productID": productID,
        "qty": qty,
        "size": size,
        "Harga": hargaP
      };
      _shopcart.doc(documentSnapshot!.id).update({
        'ListShopcart': FieldValue.arrayRemove([produk1]),
        'email': email
      });
      _shopcart.doc(documentSnapshot!.id).update({
        'ListShopcart': FieldValue.arrayUnion([produk]),
        'email': email
      });
    }
  }

  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();

  final CollectionReference _shopcart =
      FirebaseFirestore.instance.collection('shopcart');

  void addqty(DocumentSnapshot? documentSnapshot, int x) {
    if (documentSnapshot != null) {
      String email = documentSnapshot['email'];
      int productID = documentSnapshot['ListShopcart'][x]['productID'];
      String size = documentSnapshot['ListShopcart'][x]['size'];
      int qty = documentSnapshot['ListShopcart'][x]['qty'] + 1;
      int Lqty = documentSnapshot['ListShopcart'][x]['qty'];
      int hargaP = documentSnapshot['ListShopcart'][x]['Harga'];
      Map<dynamic, dynamic> produk1 = {
        "productID": productID,
        "qty": Lqty,
        "size": size,
        "Harga": hargaP
      };
      Map<dynamic, dynamic> produk = {
        "productID": productID,
        "qty": qty,
        "size": size,
        "Harga": hargaP
      };
      _shopcart.doc(documentSnapshot!.id).update({
        'ListShopcart': FieldValue.arrayRemove([produk1]),
        'email': email
      });
      _shopcart.doc(documentSnapshot!.id).update({
        'ListShopcart': FieldValue.arrayUnion([produk]),
        'email': email
      });
    }
  }

  void minqty(DocumentSnapshot? documentSnapshot, int x) {
    if (documentSnapshot != null) {
      String email = documentSnapshot['email'];
      int productID = documentSnapshot['ListShopcart'][x]['productID'];
      String size = documentSnapshot['ListShopcart'][x]['size'];
      int qty = documentSnapshot['ListShopcart'][x]['qty'] - 1;
      int Lqty = documentSnapshot['ListShopcart'][x]['qty'];
      int hargaP = documentSnapshot['ListShopcart'][x]['Harga'];
      if (Lqty > 1) {
        Map<dynamic, dynamic> produk1 = {
          "productID": productID,
          "qty": Lqty,
          "size": size,
          "Harga": hargaP
        };
        Map<dynamic, dynamic> produk = {
          "productID": productID,
          "qty": qty,
          "size": size,
          "Harga": hargaP
        };
        _shopcart.doc(documentSnapshot!.id).update({
          'ListShopcart': FieldValue.arrayRemove([produk1]),
          'email': email
        });
        _shopcart.doc(documentSnapshot!.id).update({
          'ListShopcart': FieldValue.arrayUnion([produk]),
          'email': email
        });
      }
    }
  }

  final DTshopcart = FirebaseFirestore.instance
      .collection('shopcart')
      .where("email", isEqualTo: data.email)
      .limit(1)
      .snapshots();

  void delete(DocumentSnapshot documentSnapshot, int x) {
    String email = documentSnapshot['email'];
    int productID = documentSnapshot['ListShopcart'][x]['productID'];
    String size = documentSnapshot['ListShopcart'][x]['size'];
    int qty = documentSnapshot['ListShopcart'][x]['qty'];
    int hargaP = documentSnapshot['ListShopcart'][x]['Harga'];

    Map<dynamic, dynamic> produk = {
      "productID": productID,
      "qty": qty,
      "size": size,
      "Harga": hargaP
    };

    _shopcart.doc(documentSnapshot!.id).update({
      'ListShopcart': FieldValue.arrayRemove([produk]),
      'email': email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF146C94),
          title: Text("Shopcart"),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text('Your Shopcart',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    StreamBuilder(
                        stream: DTshopcart,
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            final Titem = streamSnapshot.data!.docs;
                            return Text(
                                Titem[0]['ListShopcart'].length.toString() +
                                    ' items',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.7)));
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ],
                ),
              ),
              Flexible(
                child: StreamBuilder(
                  stream: DTshopcart,
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
                            for (int i = 0;
                                i < items[0]['ListShopcart'].length;
                                i++) ...[
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('produk')
                                      .where("ProdukID",
                                          isEqualTo: items[0]['ListShopcart'][i]
                                              ['productID'])
                                      .limit(1)
                                      .snapshots(), //mengambil data produk berdasarkan produk fav (Listwishlist)
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamSnapshot) {
                                    if (streamSnapshot.hasData) {
                                      final item = streamSnapshot.data!.docs;
                                      return Card(
                                          child: InkWell(
                                        splashColor: Color(0xFF0E5E6F),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                data.produk = items[0]
                                                        ['ListShopcart'][i]
                                                    ['productID'];
                                                return barang();
                                              },
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 170,
                                          child: Row(children: [
                                            Image(
                                              image: NetworkImage(
                                                  item[0]["image"]),
                                              width: 130,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Rp." +
                                                      item[0]['Harga']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                DropdownButton<String>(
                                                  value: items[0]
                                                          ['ListShopcart'][i][
                                                      'size'], // Nilai ukuran yang dipilih
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _selectedSize = newValue!;
                                                      Csize(documentSnapshot, i,
                                                          _selectedSize);
                                                      // Mengubah nilai ukuran yang dipilih
                                                    });
                                                  },
                                                  items: <String>[
                                                    'S',
                                                    'M',
                                                    'L',
                                                    'XL'
                                                  ].map((String size) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: size,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  8.0), // Menggeser tulisan ke kanan
                                                          Text(
                                                            size,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  underline:
                                                      Container(), // Menghilangkan garis bawah dropdown
                                                  isExpanded:
                                                      false, // Tidak mengambil ruang penuh pada baris
                                                  icon: Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            8.0), // Menggeser ikon ke kanan
                                                    child: Icon(
                                                        Icons.arrow_drop_down),
                                                  ), // Icon dropdown
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return <String>[
                                                      'S',
                                                      'M',
                                                      'L',
                                                      'XL'
                                                    ].map((String value) {
                                                      return Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  dropdownColor: Colors.white,
                                                  elevation:
                                                      2, // Mengatur elevasi dropdown
                                                  focusColor: Colors.white,
                                                  autofocus: false,
                                                  isDense:
                                                      true, // Mengurangi padding pada dropdown
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 5, 0, 0),
                                                  child: Text(
                                                    "Quantity",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      //minus button
                                                      width: 25,
                                                      height: 25,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5)),
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 15,
                                                        ),
                                                        onPressed: () =>
                                                            setState(() {
                                                          minqty(
                                                              documentSnapshot,
                                                              i);
                                                        }),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        items[0]['ListShopcart']
                                                                [i]['qty']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      //addbutton
                                                      width: 25,
                                                      height: 25,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5)),
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 15,
                                                        ),
                                                        onPressed: () =>
                                                            setState(() {
                                                          addqty(
                                                              documentSnapshot,
                                                              i);
                                                        }),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: ElevatedButton(
                                                        //hapus button
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5)),
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 15,
                                                        ),
                                                        onPressed: () =>
                                                            showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Konfirmasi'),
                                                            content: const Text(
                                                                'Apakah anda yakin menghapus item dari keranjang!'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    setState(
                                                                        () {
                                                                  delete(
                                                                      documentSnapshot,
                                                                      i);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('You have successfully deleted a product')));
                                                                  Navigator.pop(
                                                                      context,
                                                                      'Hapus');
                                                                }),
                                                                child:
                                                                    const Text(
                                                                        'Hapus'),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
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
                  },
                ),
              ),
            ],
          ),
        )),
        floatingActionButton: StreamBuilder(
            stream: DTshopcart,
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                harga = 0;
                final items = streamSnapshot.data!.docs;
                for (int i = 0; i < items[0]['ListShopcart'].length; i++) {
                  harga += items[0]['ListShopcart'][i]['Harga'] *
                      items[0]['ListShopcart'][i]['qty'];
                }
                ;
                return FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Pembayaran();
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_checkout),
                  label: Text("Rp." + harga.toString()),
                  backgroundColor: Color(0xFF146C94),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
