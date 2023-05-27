import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/constant/app_color.dart';
import 'package:homepage/core/model/wishlistM.dart';
import 'package:homepage/core/services/wishlistS.dart';
import 'package:homepage/main.dart';
import 'package:homepage/wishlisttile.dart';

class wishlist extends StatefulWidget {
  const wishlist({super.key});

  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  List<wishlistM> wishlistData = wishlistS.wishlistData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text('Your Wishlist',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            Text('9 items',
                style: TextStyle(
                    fontSize: 14, color: Colors.black.withOpacity(0.7))),
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return wishlistTile(
                data: wishlistData[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: 9,
          ),
        ],
      ),
    );
  }
}
