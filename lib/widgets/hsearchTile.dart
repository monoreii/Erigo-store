import 'package:flutter/material.dart';
import 'package:homepage/constant/app_color.dart';
import 'package:homepage/core/model/searchM.dart';

class SearchHistoryTile extends StatelessWidget {
  SearchHistoryTile({required this.data, required this.onTap});

  final SearchHistory data;
  final  onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColor.primarySoft,
              width: 1,
            ),
          ),
        ),
        child: Text(data.title),
      ),
    );
  }
}
