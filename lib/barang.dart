import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './core/services/data.dart' as data;
import './Login.dart';
import './pembayaran1.dart';

void main() async {
  runApp(const br());
}

class br extends StatelessWidget {
  const br({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'barang',
      home: barang(),
    );
  }
}

class barang extends StatefulWidget {
  const barang({super.key});

  @override
  State<barang> createState() => _barang();
}

class _barang extends State<barang> {
  DocumentSnapshot? doku;
  int position =
      data.fav; //data.fav variable global untuk menentukan warna icon love
  final CollectionReference _wishlist =
      FirebaseFirestore.instance.collection('wishlist'); //ngaambil data
  int _selectedIndex = data.fav;
  _onSelected(int index) {
    //fungsi
    //menambahkan ke wishlist
    //love button function
    setState(() {
      if (index == 0) {
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
                "Listwishlist": FieldValue.arrayUnion([data.produk])
              });
            }
          },
        );
        position = 1;
        _selectedIndex = 1;
        data.fav = 1;
      } else {
        //menghapus ke wishlist
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
                "Listwishlist": FieldValue.arrayRemove([data.produk])
              });
            }
          },
        );
        position = 0;
        _selectedIndex = 0;
        data.fav = 0;
      }
    });
  }

  final DTproduk = FirebaseFirestore.instance
      .collection('produk')
      .where("ProdukID", isEqualTo: data.produk)
      .limit(1)
      .snapshots(); //ngambil data

  String _selectedSize = 'S';
  static const String _title = 'Items Detail';
  bool _isExpanded = false;

  final CollectionReference _shopcart =
      FirebaseFirestore.instance.collection('shopcart'); //ngambil data

  void plusCart(DocumentSnapshot documentSnapshot) {
    //fungsi tambah data ke cart
    FirebaseFirestore.instance
        .collection('shopcart')
        .where("email", isEqualTo: data.email)
        .limit(1)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Map<dynamic, dynamic> produk = {
          "productID": documentSnapshot["ProdukID"],
          "qty": 1,
          "size": 'L',
          "Harga": documentSnapshot["Harga"]
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
        title: const Text('Erigo'),
        backgroundColor: const Color(0xff146C94),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            StreamBuilder(
                //narik data
                stream: DTproduk,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final produk = streamSnapshot.data!.docs;
                    return Container(
                      width: 500.0,
                      height: 500.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage(produk[0]["image"]), //nampilin data
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            const SizedBox(height: 20), // Jarak antara gambar dan teks
            StreamBuilder(
                //narik data
                stream: DTproduk,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final produk = streamSnapshot.data!.docs;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              produk[0]["NamaP"], //nampilin data
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            IconButton(
                                //tombol wishlist
                                icon: Icon(
                                  Icons.favorite,
                                  color: _selectedIndex == 1
                                      ? Colors.redAccent
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  if (data.login == false) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Anda belum login'),
                                        content: const Text(
                                            'Silahkan login terlebih dahulu!'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => {
                                              Navigator.pop(context, 'Cancel'),
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return login();
                                                  },
                                                ),
                                              ),
                                            },
                                            child: const Text('Login'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  ;
                                  _onSelected(position);
                                })
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),

            const SizedBox(height: 10), // Jarak antara teks
            StreamBuilder(
                //narik data
                stream: DTproduk,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final produk = streamSnapshot.data!.docs;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Rp." + produk[0]["Harga"].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),

            const SizedBox(
                height:
                    10.0), // Variabel untuk menyimpan pilihan ukuran yang dipilih
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 70,
                  height: 30.0, // Menambahkan tinggi dropdown
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xff888888), width: 1.0))),
                  child: DropdownButton<String>(
                    value: _selectedSize, // Nilai ukuran yang dipilih
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSize = newValue!;
                        data.size =
                            _selectedSize; // Mengubah nilai ukuran yang dipilih
                      });
                    },
                    items: <String>['S', 'M', 'L', 'XL'].map((String size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Row(
                          children: [
                            SizedBox(width: 8.0), // Menggeser tulisan ke kanan
                            Text(
                              size,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    underline:
                        Container(), // Menghilangkan garis bawah dropdown
                    isExpanded: false, // Tidak mengambil ruang penuh pada baris
                    icon: Padding(
                      padding: EdgeInsets.only(
                          right: 8.0), // Menggeser ikon ke kanan
                      child: Icon(Icons.arrow_drop_down),
                    ), // Icon dropdown
                    selectedItemBuilder: (BuildContext context) {
                      return <String>['S', 'M', 'L', 'XL'].map((String value) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      }).toList();
                    },
                    dropdownColor: Colors.white,
                    elevation: 2, // Mengatur elevasi dropdown
                    focusColor: Colors.white,
                    autofocus: false,
                    isDense: true, // Mengurangi padding pada dropdown
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi Produk',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Kemeja pria model terbaru dengan bahan yang berkualitas tinggi dan nyaman digunakan. Terdapat banyak pilihan warna dan ukuran yang bisa dipilih sesuai selera. Berbahan Katun. Kemeja pria model terbaru dengan bahan yang berkualitas tinggi dan nyaman digunakan. Terdapat banyak pilihan warna dan ukuran yang bisa dipilih sesuai selera. Berbahan Katun',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: _isExpanded ? null : 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? 'See more' : 'See less',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff146C94),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Logika ketika tombol ditekan
          // Misalnya, navigasi ke halaman checkout atau menampilkan dialog
          if (data.login == true) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Checkout Barang'),
                  content: Text('Anda akan melakukan checkout barang?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        data.size = _selectedSize;
                        // Logika untuk melanjutkan checkout
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Pembayaran1();
                            },
                          ),
                        );
                      },
                      child: Text('Checkout'),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('produk')
                            .where("ProdukID", isEqualTo: data.produk)
                            .limit(1)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            // final produk = streamSnapshot.data!.docs;
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[0];
                            return TextButton(
                              onPressed: () {
                                plusCart(documentSnapshot);
                                Navigator.of(context).pop();
                              },
                              child: Text('+Cart'),
                            );
                          }
                          return Text('error ${streamSnapshot.error}');
                        }),
                  ],
                );
              },
            );
          } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Anda belum login'),
                content: const Text('Silahkan login terlebih dahulu!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => {
                      Navigator.pop(context, 'Cancel'),
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return login();
                          },
                        ),
                      ),
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            );
          }
          ;
        },
        label: Text('Checkout Barang'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
