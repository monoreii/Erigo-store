import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homepage/Login.dart';
import 'constant/app_color.dart';
import 'package:homepage/profiletile.dart';
import './Login.dart';
import './helpdesk.dart';
import './wishlist.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
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
                      image: AssetImage('aset/images/pp.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Fullname
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 14),
                  child: Text(
                    'Mega Chan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                // Username
                Text(
                  '@bantengmerah',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 14),
                ),
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
                  child: InkWell(
                    splashColor: Color(0xFF0E5E6F),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return helpdesk();
                          },
                        ),
                      );
                    },
                    child: MenuTileWidget(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return wishlist();
                            },
                          ),
                        );
                      },
                      margin: EdgeInsets.only(top: 10),
                      icon: SvgPicture.asset(
                        'aset/icons/Heart.svg',
                        color: AppColor.secondary.withOpacity(0.5),
                      ),
                      title: 'Wishlist',
                      subtitle: 'Lorem ipsum Dolor sit Amet',
                    ),
                  ),
                ),
                MenuTileWidget(
                  onTap: () {},
                  margin: EdgeInsets.only(top: 10),
                  icon: SvgPicture.asset(
                    'aset/icons/Show.svg',
                    color: AppColor.secondary.withOpacity(0.5),
                  ),
                  title: 'Last Seen',
                  subtitle: 'Lorem ipsum Dolor sit Amet',
                ),
                Card(
                  child: InkWell(
                    splashColor: Color(0xFF0E5E6F),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return helpdesk();
                          },
                        ),
                      );
                    },
                    child: MenuTileWidget(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return helpdesk();
                            },
                          ),
                        );
                      },
                      margin: EdgeInsets.only(top: 10),
                      icon: Icon(Icons.help_center_outlined,
                          color: Colors.black.withOpacity(0.5)),
                      title: 'Helpdesk',
                      subtitle: 'Lorem ipsum Dolor sit Amet',
                    ),
                  ),
                ),
                MenuTileWidget(
                  onTap: () {},
                  margin: EdgeInsets.only(top: 10),
                  icon: SvgPicture.asset(
                    'aset/icons/Bag.svg',
                    color: AppColor.secondary.withOpacity(0.5),
                  ),
                  title: 'Orders',
                  subtitle: 'Lorem ipsum Dolor sit Amet',
                ),
                MenuTileWidget(
                  onTap: () {},
                  margin: EdgeInsets.only(top: 10),
                  icon: SvgPicture.asset(
                    'aset/icons/Wallet.svg',
                    color: AppColor.secondary.withOpacity(0.5),
                  ),
                  title: 'Wallet',
                  subtitle: 'Lorem ipsum Dolor sit Amet',
                ),
                MenuTileWidget(
                  onTap: () {},
                  icon: SvgPicture.asset(
                    'aset/icons/Location.svg',
                    color: AppColor.secondary.withOpacity(0.5),
                  ),
                  title: 'Addresses',
                  subtitle: 'Lorem ipsum Dolor sit Amet',
                  margin: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),

          // Section 3 - Settings
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
                MenuTileWidget(
                  onTap: () {},
                  margin: EdgeInsets.only(top: 10),
                  icon: SvgPicture.asset(
                    'aset/icons/Filter.svg',
                    color: AppColor.secondary.withOpacity(0.5),
                  ),
                  title: 'Languages',
                  subtitle: 'Lorem ipsum Dolor sit Amet',
                ),
                MenuTileWidget(
                  onTap: () {},
                  icon: SvgPicture.asset(
                    'aset/icons/Log Out.svg',
                    color: Color.fromRGBO(247, 247, 247, 1),
                  ),
                  iconBackground: AppColor.alert,
                  title: 'Log Out',
                  subtitle: 'Lorem ipsum Dolor sit Amet',
                  margin: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
