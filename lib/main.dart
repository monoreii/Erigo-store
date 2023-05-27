import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './Login.dart';
import './wishlist.dart';
import './homepage.dart';
import './helpdesk.dart';
import './barang.dart';
import './profile.dart';
import './shopcart.dart';
import './core/services/cartList.dart' as cartList;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      home: const MyHomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screen = [
    homepage(),
    wishlist(),
    profile(),
  ];

  final addScreen = [
    helpdesk(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Container(
          child: Image(
            image: AssetImage('aset/logo_erigo.png'),
            width: 100,
            height: 100,
            fit: BoxFit.contain, //menyesuaikan ruang yang ada
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 200.0,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Color.fromARGB(242, 255, 255, 255),
                    focusColor: Color(0xFF0E5E6F),
                    labelText: 'Cari barang',
                  ),
                ),
              ),
              RawMaterialButton(
                onPressed: () => showDialog<String>(
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
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
                fillColor: Color(0xFF19A7CE),
                child: Icon(
                  Icons.person,
                  size: 20.0,
                ),
                shape: CircleBorder(),
              ),
            ],
          )
        ],
      ),
      body: screen[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                cartList.hargaAwal = 0;
                for (var i = 0; i < cartList.cart.length; i++) {
                  cartList.hargaAwal +=
                      (cartList.cart[i]['harga'] * cartList.cart[i]['qty']);
                  cartList.qty = cartList.cart.length;
                }
                return shopcart();
              },
            ),
          );
        },
        backgroundColor: Color(0xFF146C94),
        child: const Icon(Icons.shopping_cart),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF146C94),
        selectedItemColor: Color(0xFF19A7CE),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        type: BottomNavigationBarType
            .fixed, // Tambah ini karena buat profile page
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            // Tambah Item buat page Profile
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
