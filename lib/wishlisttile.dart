import 'package:flutter/material.dart';
import 'package:homepage/constant/app_color.dart';
import 'package:homepage/core/model/wishlistM.dart';
import './shopcart.dart';

class wishlistTile extends StatelessWidget {
  final wishlistM data;
  wishlistTile({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: AppColor.border,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: AssetImage(data.image[0]), fit: BoxFit.cover),
            ),
          ),
          // Info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  '${data.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                      color: AppColor.secondary),
                ),
                // Product Price - Increment Decrement Button
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Price
                      Expanded(
                        child: Text(
                          '${data.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: AppColor.primary),
                        ),
                      ),
                      // Increment Decrement Button
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF19A7CE)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return shopcart();
                              },
                            ),
                          );
                        },
                        child: Text('+ Cart'),
                      )
                    ],
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
