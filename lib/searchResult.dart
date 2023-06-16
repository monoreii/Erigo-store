import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/constant/app_color.dart';
import 'package:homepage/core/model/productM.dart';
import 'package:homepage/core/services/pService.dart';
import 'package:homepage/widgets/itemCard.dart';

class SearchResultPage extends StatefulWidget {
  final String searchKeyword;
  SearchResultPage({required this.searchKeyword});

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchInputController = TextEditingController();
  List<Product> searchedProductData = ProductService.searchedProductData;
  @override
  void initState() {
    super.initState();
    searchInputController.text = widget.searchKeyword;
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Container(
          child: Image(
            image: AssetImage('aset/logo_erigo.png'),
            width: 100,
            height: 100,
            fit: BoxFit.contain, //menyesuaikan ruang yang ada
          ),
        ),
        elevation: 0,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 200.0,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Color.fromARGB(242, 255, 255, 255),
                    focusColor: Color(0xFF0E5E6F),
                    labelText: 'Cari barang...',
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'aset/icons/Filter.svg',
              color: Colors.white,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: AppColor.secondary,
            child: TabBar(
              controller: tabController,
              indicatorColor: AppColor.accent,
              indicatorWeight: 5,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'poppins',
                  fontSize: 12),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'poppins',
                  fontSize: 12),
              tabs: [
                Tab(
                  text: 'Related',
                ),
                Tab(
                  text: 'Newest',
                ),
                Tab(
                  text: 'Popular',
                ),
                Tab(
                  text: 'Best Seller',
                ),
              ],
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // 1 - Related
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'Search result of ${widget.searchKeyword}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    searchedProductData.length,
                    (index) => ItemCard(
                      product: searchedProductData[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 2 - Newest
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'Newest Products',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    searchedProductData.length,
                    (index) => ItemCard(
                      product: searchedProductData[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 3 - Popular
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'Popular Products',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    searchedProductData.length,
                    (index) => ItemCard(
                      product: searchedProductData[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 4 - Best Seller
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'Best Selling Products',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    searchedProductData.length,
                    (index) => ItemCard(
                      product: searchedProductData[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
