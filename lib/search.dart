import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/constant/app_color.dart';
import 'package:homepage/core/model/searchM.dart';
import 'package:homepage/core/services/searchS.dart';
import 'package:homepage/searchResult.dart';
import 'package:homepage/widgets/psearchCard.dart';
import 'package:homepage/widgets/hsearchTile.dart';
import './Login.dart';
import 'barang.dart';
import './core/services/data.dart' as dataLogin;
import './main.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchHistory> listSearchHistory = SearchService.listSearchHistory;
  List<PopularSearch> listPopularSearch = SearchService.listPopularSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
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
              RawMaterialButton(
                onPressed: () => {
                  if (dataLogin.login == false)
                    {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Anda belum login'),
                          content:
                              const Text('Silahkan login terlebih dahulu!'),
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
                                      return login();
                                    },
                                  ),
                                ),
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    }
                  else
                    {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Anda sudah login'),
                          content: const Text('Apakah anda mau log out'),
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
                                      dataLogin.login = false;
                                      dataLogin.email = "";
                                      return MyApp();
                                    },
                                  ),
                                ),
                              },
                              child: const Text('Log out'),
                            ),
                          ],
                        ),
                      ),
                    }
                },
                fillColor:
                    dataLogin.login == true ? Color(0xFF19A7CE) : Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 20.0,
                ),
                shape: CircleBorder(),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Search History
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Search history...',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listSearchHistory.length,
                itemBuilder: (context, index) {
                  return SearchHistoryTile(
                    data: listSearchHistory[index],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchResultPage(
                            searchKeyword: listSearchHistory[index].title,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Delete search history',
                    style:
                        TextStyle(color: AppColor.secondary.withOpacity(0.5)),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.primary.withOpacity(0.3),
                    backgroundColor: AppColor.primarySoft,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                  ),
                ),
              ),
            ],
          ),
          // Section 2 - Popular Search
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Popular search.',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: List.generate(listPopularSearch.length, (index) {
                  return PopularSearchCard(
                    data: listPopularSearch[index],
                    onTap: () {},
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
