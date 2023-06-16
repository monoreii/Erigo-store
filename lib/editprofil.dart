import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/Login.dart';
import 'package:homepage/pembayaran.dart';
import 'constant/app_color.dart';
import './Login.dart';
import './helpdesk.dart';
import './wishlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './core/services/data.dart' as data;

void main() async {
  runApp(const edp());
}

class edp extends StatelessWidget {
  const edp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'editprofile',
      home: editprofile(),
    );
  }
}

class editprofile extends StatefulWidget {
  @override
  State<editprofile> createState() => _editprofile();
}

class _editprofile extends State<editprofile> {
  @override
  EdgeInsetsGeometry margin = EdgeInsets.all(10.0);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _nTeleponController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _kodePosController = TextEditingController();

  final DTakun = FirebaseFirestore.instance
      .collection('akun')
      .where("email", isEqualTo: data.email)
      .limit(1)
      .snapshots();

  final collection = FirebaseFirestore.instance.collection('akun');

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _emailController.text = documentSnapshot['email'];
      _passwordController.text = documentSnapshot['password'];
      _alamatController.text = documentSnapshot['alamat'];
      _nTeleponController.text = documentSnapshot['nTelepon'];
      _namaController.text = documentSnapshot['nama'];
      _kodePosController.text = documentSnapshot['kodePos'];
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
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                TextField(
                  controller: _nTeleponController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                  ),
                ),
                TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _kodePosController,
                  decoration: InputDecoration(
                    labelText: 'Kode Pos',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    collection.doc(documentSnapshot!.id).update({
                      "alamat": _alamatController.text,
                      "email": _emailController.text,
                      "nTelepon": _nTeleponController.text,
                      "nama": _namaController.text,
                      "password": _passwordController.text,
                      "kodePos": _kodePosController.text
                    });
                    Navigator.pop(context, 'Cancel');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Data berhasil diupdate')));
                  },
                )
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: const Color(0xff146C94),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Profile Picture - Username - Name
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('aset/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Profile Picture
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage('aset/ErigoPP.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: DTakun,
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[0];
                  final akun = streamSnapshot.data!.docs;
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Nama'),
                          subtitle: Text(akun[0]['nama']),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Email'),
                          subtitle: Text(akun[0]['email']),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Password'),
                          subtitle: Text(akun[0]['password']),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Nomor Telepon'),
                          subtitle: Text(akun[0]['nTelepon']),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Alamat'),
                          subtitle: Text(akun[0]['alamat']),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Kode Pos'),
                          subtitle: Text(akun[0]['kodePos']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Update Data'),
                                      content: const Text(
                                          'Apakah anda yakin ingin merubah data?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _update(documentSnapshot);
                                            Navigator.pop(context, 'Cancel');
                                          },
                                          child: const Text('Oke'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text('Update'),
                              ),
                              // OutlinedButton(
                              //   onPressed: () {
                              //     // Logika untuk membatalkan perubahan profil
                              //   },
                              //   child: Text('Update'),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
