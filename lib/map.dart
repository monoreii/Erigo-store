import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:latlong/latlong.dart';
// import 'package:geocode/geocode.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import './core/services/data.dart' as data;

void main() {
  runApp(const MP());
}

class MP extends StatelessWidget {
  const MP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: maps(),
    );
  }
}

class maps extends StatefulWidget {
  const maps({Key? key}) : super(key: key);

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {
  double lat = -6.969345;
  double long = 107.628622;
  LatLng loc = LatLng(data.long, data.lat);

  var location = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF146C94),
        title: new Text('Map Application'),
      ),
      body: Stack(
        children: <Widget>[
          new FlutterMap(
              options: new MapOptions(
                  minZoom: 15.0,
                  center: loc), //new LatLng(-6.969345, 107.628622)
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(markers: [
                  Marker(
                      width: 45.0,
                      height: 45.0,
                      point:
                          loc, //40.73, -74.00 new LatLng(-6.969345, 107.628622)
                      builder: (context) => new Container(
                            child: IconButton(
                                icon: Icon(Icons.accessibility),
                                onPressed: () {
                                  print('Marker tapped!');
                                }),
                          ))
                ])
              ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await _getGeoLocationPosition();
          setState(() {
            // long = position.longitude;
            // lat = position.latitude;
            loc = LatLng(position.latitude, position.longitude);
          });
        },
        backgroundColor: Color(0xFF146C94),
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
