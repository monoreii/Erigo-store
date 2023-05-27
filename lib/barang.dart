import 'package:flutter/material.dart';

class barang extends StatefulWidget {
  const barang({super.key});

  @override
  State<barang> createState() => _barang();
}

class _barang extends State<barang> {
  String _selectedSize = 'S';
  static const String _title = 'Items Detail';
  bool _isExpanded = false;
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
            Container(
              width: 500.0,
              height: 500.0,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('aset/Anorak_Jacket.jpg'),
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
            ),
            const SizedBox(height: 20), // Jarak antara gambar dan teks
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Anorak Jacket',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Jarak antara teks
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Rp 100.000',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'S';
                        });
                      },
                      child: const Text(
                        'S',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: const Color(0xff146C94),
                        side: const BorderSide(
                          color: const Color(0xff146C94),
                          width: 1.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'M';
                        });
                      },
                      child: const Text(
                        'M',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff146C94),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'L';
                        });
                      },
                      child: const Text(
                        'L',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff146C94),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'XL';
                        });
                      },
                      child: const Text(
                        'XL',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff146C94),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                      ),
                    ),
                  ],
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
                      'Kemeja pria model terbaru dengan bahan yang berkualitas tinggi dan nyaman digunakan. Terdapat banyak pilihan warna dan ukuran yang bisa dipilih sesuai selera.Berbahan Katun',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: _isExpanded ? null : 3,
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
                        _isExpanded ? 'See less' : 'See more',
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
    );
  }
}
