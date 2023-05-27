import 'package:flutter/material.dart';
import './main.dart';
import './core/services/cartList.dart' as cartList;

class Pembayaran extends StatefulWidget {
  const Pembayaran({super.key});

  @override
  State<Pembayaran> createState() => _Pembayaran();
}

class _Pembayaran extends State<Pembayaran> {
  // Initial Selected Value
  String mtdPengiriman = 'Reguler';
  final TextEditingController controlAP = TextEditingController();
  final TextEditingController controlKP = TextEditingController();

  // List of items in our dropdown menu
  var listPengiriman = [
    'Reguler',
    'Next day',
  ];

  // Initial Selected Value
  String logoPembayaran = 'aset/Mandiri.png';
  String mtdPembayaran = 'Mandiri';

  // List of items in our dropdown menu
  var listPembayaran = [
    'Mandiri',
    'BCA',
    'BRI',
    'BNI',
  ];

  void FlogoPembayaran (){
    switch(mtdPembayaran){
      case 'Mandiri':
        logoPembayaran = 'aset/Mandiri.png';
        break;
      case 'BCA':
        logoPembayaran = 'aset/BCA.png';
        break;
      case 'BRI':
        logoPembayaran = 'aset/BRI.png';
        break;
      case 'BNI':
        logoPembayaran = 'aset/BNI.png';
        break;
    }
  }
  String code = '';
  int biaya = 0;
  void Bpengiriman (){
    String temp = controlKP.text;
    List<String> Listcode = temp.split('');
    code = Listcode[0];
    switch(mtdPengiriman) {
      case 'Reguler':
        switch(code) {
          case "1":
            biaya = 10000;
            break;
          case "2":
            biaya = 20000;
            break;
          case "3":
            biaya = 22000;
            break;
          case "4":
            biaya = 13000;
            break;
          case "5":
            biaya = 15000;
            break;
          case "6":
            biaya = 17000;
            break;
          case "7":
            biaya = 25000;
            break;
          case "8":
            biaya = 22000;
            break;
          case "9":
            biaya = 28000;
            break;
        }
        break;
      case 'Next day':
        switch(code) {
          case "1":
            biaya = 15000;
            break;
          case "2":
            biaya = 25000;
            break;
          case "3":
            biaya = 27000;
            break;
          case "4":
            biaya = 18000;
            break;
          case "5":
            biaya = 20000;
            break;
          case "6":
            biaya = 23000;
            break;
          case "7":
            biaya = 30000;
            break;
          case "8":
            biaya = 27000;
            break;
          case "9":
            biaya = 33000;
            break;
        }
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("Pembayaran"),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(children: [
              for (var i = 0; i < cartList.cart.length; i++) ...[
                Card(
                    child: SizedBox(
                  width: 150,
                  height: 170,
                  child: Row(children: [
                    Image(
                      image: AssetImage('aset/Anorak_Jacket.jpg'),
                      width: 150,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartList.cart[i]['produk'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                            "Rp."+cartList.cart[i]['harga'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          cartList.cart[i]['size'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Text(
                              cartList.cart[i]['qty'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                )),],
                Card(
                  child: SizedBox(
                    width: 150,
                    height: 450,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alamat pengiriman",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: controlAP,
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Alamat pengiriman',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: controlKP,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Kode Pos',
                          ),
                          onSubmitted: (inputValue) {Bpengiriman();},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(Icons.local_shipping),
                            Text(" Jenis pengiriman $code",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              // Initial Value
                              value: mtdPengiriman,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: listPengiriman.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  mtdPengiriman = newValue!;
                                  Bpengiriman();
                                });
                              },
                            ),
                            Text("Rp."+biaya.toString()),
                          ],
                        ),
                        Text("Estimasi tiba 17 Apr"),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Metode Pembayaran",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Row(
                          children: [
                            DropdownButton(
                              // Initial Value
                              value: mtdPembayaran,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: listPembayaran.map((String items1) {
                                return DropdownMenuItem(
                                  value: items1,
                                  child: Text(items1),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue1) {
                                setState(() {
                                  mtdPembayaran = newValue1!;
                                  FlogoPembayaran();
                                });
                              },
                            ),
                            Image(
                              image: AssetImage(logoPembayaran),
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                          ],

                        ),
                      ],
                    ),
                  ),
                ),
              ]))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Pembayaran berhasil'),
            content: const Text('Terima kasih sudah berbelanja di toko kami'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyApp();
                      },
                    ),
                  );
                },
                child: const Text('Lanjut berbelanja'),
              ),
            ],
          ),
        ),
        icon: Icon(Icons.payments),
        label: Text("Rp."+cartList.hargaAwal.toString()),
        backgroundColor: Color(0xFF146C94),
      ),
    );
  }
}
