import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/Login.dart';
import 'constant/app_color.dart';
import 'package:homepage/profiletile.dart';
import './Login.dart';
import './helpdesk.dart';
import './wishlist.dart';
import './editprofil.dart';
import './core/services/data.dart' as data;
import './main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './pembayaran.dart';
import './pesanan.dart';
import './offStore.dart';
import './camera.dart';
import './map.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  runApp(const pp());
}

class pp extends StatelessWidget {
  const pp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'profile',
      home: profile(),
    );
  }
}

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  final DTakun = FirebaseFirestore.instance
      .collection('akun')
      .where("email", isEqualTo: data.email)
      .limit(1)
      .snapshots();

  @override
  EdgeInsetsGeometry margin = EdgeInsets.all(10.0);

  Widget build(BuildContext context) {
    return Scaffold(
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
                // Fullname
                StreamBuilder(
                    stream: DTakun,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final akun = streamSnapshot.data!.docs;
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4, top: 14),
                              child: Text(
                                akun[0]['nama'], //nama
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            // Username
                            Text(
                              akun[0]['email'],
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 14),
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            ),
          ),
          // Section 2 - Account Menu
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    'ACCOUNT',
                    style: TextStyle(
                        color: AppColor.secondary.withOpacity(0.5),
                        letterSpacing: 6 / 100,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pesanan(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.history,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Riwayat Pemesanan'),
                    subtitle: Text('Lorem ipsum Dolor sit Amet'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => helpdesk(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.help,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Helpdesk'),
                    subtitle: Text('Lorem ipsum Dolor sit Amet'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pembayaran(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.payment,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Pembayaran'),
                    subtitle: Text('Lorem ipsum Dolor sit Amet'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () async {
                      Position position = await _getGeoLocationPosition();
                      data.lat = position.latitude;
                      data.long = position.longitude;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => offStore(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.store,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Offline Store'),
                    subtitle: Text('Lorem ipsum Dolor sit Amet'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Camera(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Scan QR Promo'),
                    subtitle: Text('Lorem ipsum Dolor sit Amet'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                        color: AppColor.secondary.withOpacity(0.5),
                        letterSpacing: 6 / 100,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => editprofile(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.settings,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Edit Profil'),
                    subtitle: Text('Edit profil akun anda'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => maps(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.map,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Get Location'),
                    subtitle: Text('Lokasi anda'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Apakah anda mau log out?'),
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
                                      data.login = false;
                                      data.email = "";
                                      return MyApp();
                                    },
                                  ),
                                ),
                              },
                              child: const Text('Log out'),
                            ),
                          ],
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.logout,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text('Logout'),
                    subtitle: Text('Keluar dari akun anda / Ganti akun anda'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
