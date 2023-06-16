import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DummySearchWidget extends StatelessWidget {
  final onTap;

  DummySearchWidget({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'aset/icons/Search.svg',
                color: Colors.black,
                width: 18,
                height: 18,
              ),
            ),
            Text(
              'Cari Barang...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
