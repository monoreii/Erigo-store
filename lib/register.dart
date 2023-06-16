import 'package:flutter/material.dart';
import './Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(const reg());
}

class reg extends StatelessWidget {
  const reg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'register',
      home: register(),
    );
  }
}

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _namaController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _alamatController = TextEditingController();
    TextEditingController _kodePosController = TextEditingController();
    TextEditingController _nTeleponController = TextEditingController();

    bool passwordNotVisible = true;

    final CollectionReference _user =
        FirebaseFirestore.instance.collection('akun');

    final CollectionReference _shopcart =
        FirebaseFirestore.instance.collection('shopcart');

    final CollectionReference _wishlist =
        FirebaseFirestore.instance.collection('wishlist');

    final CollectionReference _pesanan =
        FirebaseFirestore.instance.collection('pesanan');

    Future<void> _regiter() async {
      final String nama = _namaController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String alamat = _alamatController.text;
      final String nTelepon = _nTeleponController.text;
      final String kodePos = _kodePosController.text;

      bool emailFound = false;
      FirebaseFirestore.instance
          .collection('akun')
          .where("email", isEqualTo: _emailController.text)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc.get('email') == _emailController.text) {
            emailFound = true;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email sudah terdaftar')));
          } else {
            emailFound = false;
          }
        });
        if (emailFound == false) {
          _user.add({
            "email": email,
            "password": password,
            "nama": nama,
            "nTelepon": nTelepon,
            "alamat": alamat,
            "kodePos": kodePos
          });

          _wishlist.add({
            "email": email,
            "Listwishlist": []
          }); //untuk menambhakan data ditabel wishlist
          _shopcart.add({"email": email, "ListShopcart": []});
          _pesanan.add({"email": email, "Lpesanan": []});
          _namaController.text = '';
          _emailController.text = '';
          _passwordController.text = '';
          _alamatController.text = '';
          _nTeleponController.text = '';

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registrasi berhasil')));
          Navigator.pop(context);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('aset/logo_erigo.png')),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: passwordNotVisible,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _kodePosController,
                decoration: InputDecoration(
                  labelText: 'Kode pos',
                  prefixIcon: Icon(Icons.local_post_office),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _nTeleponController,
                decoration: InputDecoration(
                  labelText: 'No Telepon',
                  prefixIcon: Icon(Icons.call),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    _regiter();
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
