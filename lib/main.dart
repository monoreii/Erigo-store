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
import './core/services/data.dart' as dataLogin;
import './search.dart';

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
      if ((index == 1 && dataLogin.login == false) ||
          (index == 2 && dataLogin.login == false)) {
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
      } else {
        _selectedIndex = index;
      }
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
                width: 180.0,
                child: SizedBox(
                  height: 40.0, // Tentukan tinggi yang diinginkan
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      //Your code here
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.transparent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Cari barang',
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0), // Ubah padding vertikal
                    ),
                  ),
                ),
              ),
              RawMaterialButton(
                onPressed: () => {
                  if (dataLogin.login == false)
                    {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Anda belum login'),
                          content:
                              const Text('Silahkan login terlebih dahulu!'),
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
                      ),
                    }
                  else
                    {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Anda sudah login'),
                          content: const Text('Apakah anda mau log out'),
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
                                      dataLogin.login = false;
                                      dataLogin.email = "";
                                      return MyApp();
                                    },
                                  ),
                                ),
                              },
                              child: const Text('Log out'),
                            ),
                          ],
                        ),
                      ),
                    }
                },
                fillColor:
                    dataLogin.login == true ? Color(0xFF19A7CE) : Colors.grey,
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
          if (dataLogin.login == false) {
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
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  // cartList.hargaAwal = 0;
                  // for (var i = 0; i < cartList.cart.length; i++) {
                  //   cartList.hargaAwal +=
                  //       (cartList.cart[i]['harga'] * cartList.cart[i]['qty']);
                  //   cartList.qty = cartList.cart.length;
                  // }
                  return shopcart();
                },
              ),
            );
          }
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
            icon: Icon(Icons.favorite),
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
