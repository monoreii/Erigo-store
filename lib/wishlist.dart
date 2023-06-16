import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/constant/app_color.dart';
import 'package:homepage/core/model/wishlistM.dart';
import 'package:homepage/core/services/wishlistS.dart';
import 'package:homepage/main.dart';
import 'package:homepage/wishlisttile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './barang.dart';
import './core/services/data.dart' as data;

class wishlist extends StatefulWidget {
  const wishlist({super.key});

  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  List<wishlistM> wishlistData = wishlistS.wishlistData;

  final CollectionReference _wishlist =
      FirebaseFirestore.instance.collection('wishlist');

  final CollectionReference _shopcart =
      FirebaseFirestore.instance.collection('shopcart');

  final DTwishlist = FirebaseFirestore.instance
      .collection('wishlist')
      .where("email", isEqualTo: data.email)
      .limit(1)
      .snapshots();

  void delWishlist(int x) {
    FirebaseFirestore.instance
        .collection('wishlist')
        .where("email", isEqualTo: data.email)
        .limit(1)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          _wishlist.doc(docSnapshot.id).update({
            "email": docSnapshot.data()['email'],
            "Listwishlist": FieldValue.arrayRemove([x])
          });
        }
      },
    );
  }

  void plusCart(int idProduk, int harga) {
    FirebaseFirestore.instance
        .collection('shopcart')
        .where("email", isEqualTo: data.email)
        .limit(1)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Map<dynamic, dynamic> produk = {
          "productID": idProduk,
          "qty": 1,
          "size": 'L',
          "Harga": harga
        };
        _shopcart.doc(docSnapshot.id).update({
          "email": docSnapshot.data()['email'],
          "ListShopcart": FieldValue.arrayUnion([produk])
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text('Your Wishlist',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            StreamBuilder(
                stream: DTwishlist,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final item = streamSnapshot.data!.docs;
                    return Text(
                        item[0]['Listwishlist'].length.toString() + ' items',
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
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(5),
        children: [
          StreamBuilder(
              stream: DTwishlist, //mengambil seluruh data produk di wishlist
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final items = streamSnapshot.data!.docs;
                  return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(16),
                      children: [
                        for (int i = 0;
                            i < items[0]['Listwishlist'].length;
                            i++) ...[
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('produk')
                                  .where("ProdukID",
                                      isEqualTo: items[0]['Listwishlist'][i])
                                  .limit(1)
                                  .snapshots(), //mengambil data produk berdasarkan produk fav (Listwishlist)
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  final item = streamSnapshot.data!.docs;
                                  return Card(
                                    //kotak 1
                                    clipBehavior: Clip
                                        .hardEdge, //membuat clip rounded di ujung persegi
                                    child: InkWell(
                                      splashColor: Color(0xFF0E5E6F),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              data.produk =
                                                  items[0]['Listwishlist'][i];
                                              return barang();
                                            },
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 100,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image(
                                                  image: NetworkImage(
                                                      item[0]["image"]),
                                                  width: 100,
                                                  height: 80,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 15, 0, 0),
                                                    child: Text(
                                                      item[0]['NamaP'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 0, 0),
                                                    child: Text(
                                                      "Rp." +
                                                          item[0]['Harga']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 0, 0),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                plusCart(
                                                                    items[0][
                                                                            'Listwishlist']
                                                                        [i],
                                                                    item[0][
                                                                        'Harga']);
                                                              },
                                                              child: Text(
                                                                "+ Cart",
                                                              ))),
                                                      SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child: ElevatedButton(
                                                          //hapus button
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5)),
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 15,
                                                          ),
                                                          onPressed: () =>
                                                              showDialog<
                                                                  String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Konfirmasi'),
                                                              content: const Text(
                                                                  'Apakah anda yakin menghapus item dari wishlist!'),
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
                                                                    delWishlist(
                                                                        items[0]['Listwishlist']
                                                                            [
                                                                            i]);
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Hapus');
                                                                  }),
                                                                  child: const Text(
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
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ],
                      ]);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
      // ListView(
      //   shrinkWrap: true,
      //   physics: BouncingScrollPhysics(),
      //   padding: EdgeInsets.all(16),
      //   children: [
      //     Card(
      //       //kotak 1
      //       clipBehavior: Clip.hardEdge, //membuat clip rounded di ujung persegi
      //       child: InkWell(
      //         splashColor: Color(0xFF0E5E6F),
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return barang();
      //               },
      //             ),
      //           );
      //         },
      //         child: SizedBox(
      //           width: double.infinity,
      //           height: 100,
      //           child: Row(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Image(
      //                     image: AssetImage('aset/Anorak_Jacket.jpg'),
      //                     width: 100,
      //                     height: 80,
      //                     fit: BoxFit.contain,
      //                   ),
      //                 ),
      //                 Column(
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      //                       child: Text(
      //                         "NamaP",
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.bold, fontSize: 15),
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      //                       child: Text(
      //                         "Rp." + "Harga",
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                     ),
      //                     Padding(
      //                         padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      //                         child: TextButton(
      //                             onPressed: () => {},
      //                             child: Text(
      //                               "+ Cart",
      //                             ))),
      //                   ],
      //                 ),
      //               ]),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
