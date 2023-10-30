import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App Services/global_vars.dart';
import '../../constants/color_app.dart';

import '../../views_screen/home_screen/Jobs_screen.dart';

import '../../views_screen/home_screen/job_history_screen.dart';
import '../../views_screen/home_screen/job_search_screen.dart';
import '../../views_screen/profile_screen/profile_base_screen.dart';

class Bar extends StatefulWidget {
  final int id;
  final String? isSearch;
  final int ?page;

  Bar({Key? key, required this.id, this.isSearch,this.page}) : super(key: key);

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {

  String? tokenSessionCupertio;
  int? cupertinoId;

  checkSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      tokenSessionCupertio = sp.getString('tokenProvider').toString();
      //cupertinoId=sp.getInt("cupertinoId");
    });
  }

  CupertinoTabController? tabController;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> forthTabNavKey = GlobalKey<NavigatorState>();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();

    print(widget.id.toString() + "pick id ");
    var isDataSearch = widget.isSearch;
    int? cuId = widget.id.toString() == 'null' ? 0 : widget.id;
    tabController = CupertinoTabController(initialIndex: cuId);
  }

  final List<Widget> _pages = [
    SearchScreen(
      tokenCuperTino: GlobalVarData.cupertinoSession,
      searchData: '',
    ),
    JobSearchScreen(
      tokenCuperTino: GlobalVarData.cupertinoSession,

    ),
    JobHistoryScreen(
      selectedPage:GlobalVarData.navTabBar,
      tokenCuperTino: GlobalVarData.cupertinoSession,
    ),
    ProfileBasicScreen(
      tokenCuperTino: GlobalVarData.cupertinoSession,
    ),
  ];

  // List<Widget> _pages(){
  //   return [
  //   SearchScreen(
  //     tokenCuperTino: tokenSessionCupertio.toString(),
  //     searchData: widget.isSearch,),
  //   JobSearchScreen(
  //   tokenCuperTino: tokenSessionCupertio.toString(),
  //   ),
  //   JobHistoryScreen(
  //   tokenCuperTino: tokenSessionCupertio.toString(),
  //   ),
  //   ProfileBasicScreen(
  //   // tokenCuperTino: tokenSessionCupertio.toString(),
  //   ),
  //   ];
  //
  // }
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [
      firstTabNavKey,
      secondTabNavKey,
      thirdTabNavKey,
      forthTabNavKey
    ];
    String data = widget.id.toString();
    int _index = int.parse(data);
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return
        //   PersistentTabView(
        //   context,
        //   screens: _buildScreen(),
        //   items:[
        //     PersistentBottomNavBarItem(
        //
        //         icon: Icon(Icons.account_balance_outlined)
        //     ),
        //     PersistentBottomNavBarItem(
        //         icon: Icon(Icons.search)
        //     ),
        //     PersistentBottomNavBarItem(
        //         icon: Icon(Icons.home)
        //     ),
        //     PersistentBottomNavBarItem(
        //         icon: Icon(Icons.add)
        //     ),
        //   ] ,
        //
        // );
        WillPopScope(
      onWillPop: () async {
        return !await listOfKeys[tabController!.index].currentState!.maybePop();
      },
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
        controller: tabController,
        tabBar: CupertinoTabBar(
            activeColor: ColorApp.colorprimary,
            inactiveColor: isDarkMode == false
                ? ColorApp.colorblackgalf
                : ColorApp.colorblackgalf,
            backgroundColor: isDarkMode == false
                ? const Color(0xffF8F8F8)
                : const Color(0xff181818),
            border: null,
            //  backgroundColor: Color(0xff2086AE),
            items: [
              BottomNavigationBarItem(
                  backgroundColor: isDarkMode == false
                      ? ColorApp.colorblackgalf
                      : ColorApp.colorblackgalf,
                  icon: Icon(
                    Icons.home,
                    color: isDarkMode == false
                        ? ColorApp.colorblackgalf
                        : ColorApp.colorblackgalf,
                  ),
                  activeIcon: Icon(Icons.home,
                      color: isDarkMode == false
                          ? ColorApp.colorprimary
                          : ColorApp.colorprimary),
                  label: 'Home',
                  tooltip: 'tool tip'),
              BottomNavigationBarItem(
                  backgroundColor: isDarkMode == false
                      ? ColorApp.colorblackgalf
                      : ColorApp.colorblackgalf,
                  icon: Icon(Icons.search,
                      color: isDarkMode == false
                          ? ColorApp.colorblackgalf
                          : ColorApp.colorblackgalf),
                  activeIcon: Icon(Icons.search,
                      color: isDarkMode == false
                          ? ColorApp.colorprimary
                          : ColorApp.colorprimary),
                  label: 'Search'),
              BottomNavigationBarItem(
                  backgroundColor: isDarkMode == false
                      ? ColorApp.colorblackgalf
                      : ColorApp.colorblackgalf,
                  icon: Icon(Icons.bookmark_border_outlined,
                      color: isDarkMode == false
                          ? ColorApp.colorblackgalf
                          : ColorApp.colorblackgalf),
                  activeIcon: Icon(Icons.bookmark_border_outlined,
                      color: isDarkMode == false
                          ? ColorApp.colorprimary
                          : ColorApp.colorprimary),
                  label: 'History'),
              BottomNavigationBarItem(
                  backgroundColor: isDarkMode == false
                      ? ColorApp.colorblackgalf
                      : ColorApp.colorblackgalf,
                  icon: Icon(Icons.person_outline,
                      color: isDarkMode == false
                          ? ColorApp.colorblackgalf
                          : ColorApp.colorblackgalf),
                  activeIcon: Icon(Icons.person,
                      color: isDarkMode == false
                          ? ColorApp.colorprimary
                          : ColorApp.colorprimary),
                  label: 'Profile'),
            ],
            currentIndex: _index,
            onTap: (index2) async {
              if (_index == index) {
                // Navigate to the tab's root route
                listOfKeys[index].currentState!.popUntil((route) {
                  return route.isFirst;
                });
              }
              _index = index;
            }),
        tabBuilder: (context, index) {

          if (index == 0) {
            return CupertinoTabView(
              navigatorKey: listOfKeys[index],
              builder: (context) {

                return SearchScreen(
                  tokenCuperTino: tokenSessionCupertio.toString(),
                  searchData: widget.isSearch,
                );
              },
            );
          } else if (index == 1) {
            return CupertinoTabView(
              navigatorKey: listOfKeys[index],
              builder: (context) {
                return JobSearchScreen(
                  tokenCuperTino: tokenSessionCupertio.toString(),
                );
              },
            );
          } else if (index == 2) {
            return CupertinoTabView(
              navigatorKey: listOfKeys[index],
              builder: (context) {
                return JobHistoryScreen(
                  selectedPage: widget.page,
                  tokenCuperTino: tokenSessionCupertio.toString(),
                );
              },
            );
          } else if (index == 3) {
            return CupertinoTabView(
              navigatorKey: listOfKeys[index],
              builder: (context) {
                return ProfileBasicScreen(
                  tokenCuperTino: tokenSessionCupertio.toString(),
                );
              },
            );
          } else {
            return CupertinoTabView(
              builder: (context) {
                return  ProfileBasicScreen(
                  tokenCuperTino: GlobalVarData.cupertinoSession,
                );
              },
            );
          }

        },
      ),
    );
  }
}
