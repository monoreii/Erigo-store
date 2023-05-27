import 'package:flutter/material.dart';
import './pembayaran.dart';
import './core/services/cartList.dart' as cartList;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  int _counter = cartList.qty;
  int _selectedIndex = 1;
  num total = cartList.hargaAwal;

  //firebase

  //increase the value of the counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //reset the counter value to 0-
  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 1) {
        _counter = 1;
      }
    });
  }

// Initial Selected Value
  String dropdownvalue = 'L';

  // List of items in our dropdown menu
  var items = [
    'S',
    'M',
    'L',
    'XL',
  ];

  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();

  final CollectionReference _shopcart =
      FirebaseFirestore.instance.collection('shopcart');

  void addqty([DocumentSnapshot? documentSnapshot]) {
    if (documentSnapshot != null) {
      String name = documentSnapshot['name'];
      String size = documentSnapshot['size'];
      int qty = documentSnapshot['qty'] + 1;
      _shopcart
          .doc(documentSnapshot!.id)
          .update({"name": name, "price": 100000, "qty": qty, "size": size});
    }
  }

  void minqty([DocumentSnapshot? documentSnapshot]) {
    if (documentSnapshot != null) {
      String name = documentSnapshot['name'];
      String size = documentSnapshot['size'];
      int qty = documentSnapshot['qty'] - 1;
      if (qty < 1) {
        qty = 1;
      }
      _shopcart
          .doc(documentSnapshot!.id)
          .update({"name": name, "price": 100000, "qty": qty, "size": size});
    }
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _sizeController,
                  decoration: const InputDecoration(labelText: 'Size'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _qtyController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String size = _sizeController.text;
                    final int? qty = int.tryParse(_qtyController.text);
                    if (qty != null) {
                      await _shopcart.add({
                        "name": name,
                        "price": 100000,
                        "qty": qty,
                        "size": size
                      });

                      _nameController.text = '';
                      _qtyController.text = '';
                      _sizeController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _sizeController.text = documentSnapshot['size'];
      _qtyController.text = documentSnapshot['qty'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _sizeController,
                  decoration: const InputDecoration(labelText: 'Size'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _qtyController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String size = _sizeController.text;
                    final int? qty = int.tryParse(_qtyController.text);
                    if (qty != null) {
                      await _shopcart.doc(documentSnapshot!.id).update({
                        "name": name,
                        "price": 100000,
                        "qty": qty,
                        "size": size
                      });
                      _nameController.text = '';
                      _qtyController.text = '';
                      _sizeController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _shopcart.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
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
                  Text('$_counter items',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.7))),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF19A7CE)),
                    ),
                    onPressed: () => _create(),
                    child: Text('Add items'),
                  )
                ],
              ),
            ),
            Flexible(
              child: StreamBuilder(
                stream: _shopcart.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                            child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          child: Row(children: [
                            Image(
                              image: AssetImage('aset/Anorak_Jacket.jpg'),
                              width: 130,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      documentSnapshot['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      " ( " + documentSnapshot['size'] + " )",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rp." + documentSnapshot['price'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                  child: Text(
                                    "Quantity",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      //minus button
                                      width: 25,
                                      height: 25,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(5)),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                        onPressed: () => setState(() {
                                          minqty(documentSnapshot);
                                        }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        documentSnapshot['qty'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      //addbutton
                                      width: 25,
                                      height: 25,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(5)),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        onPressed: () => setState(() {
                                          addqty(documentSnapshot);
                                        }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                      height: 5,
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () =>
                                            _update(documentSnapshot)),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: ElevatedButton(
                                        //hapus button
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 255, 0, 0),
                                            padding: EdgeInsets.all(5)),
                                        child: Icon(
                                          Icons.delete,
                                          size: 15,
                                        ),
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Konfirmasi'),
                                            content: const Text(
                                                'Apakah anda yakin menghapus item dari keranjang!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => setState(() {
                                                  _delete(documentSnapshot.id);
                                                  Navigator.pop(
                                                      context, 'Hapus');
                                                }),
                                                child: const Text('Hapus'),
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
                        ));
                      },
                    );
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
      floatingActionButton: FloatingActionButton.extended(
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
        label: Text("Rp. 100000"),
        backgroundColor: Color(0xFF146C94),
      ),
    );
  }
}
