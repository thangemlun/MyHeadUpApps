import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:head_up_ui/bloc/user_info_bloc.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/services/auth_service.dart';
import 'package:head_up_ui/services/impl/weather_service_impl.dart';
import 'package:head_up_ui/services/weather_service.dart';
import 'package:head_up_ui/views/dashboard_module/dashboard_page.dart';
import 'package:head_up_ui/views/loader_page.dart';
import 'package:head_up_ui/views/my_appbar.dart';
import 'package:head_up_ui/views/shared/skeleton.dart';
import 'package:head_up_ui/views/user_logout_drawer.dart';
import 'package:head_up_ui/views/user_module/user_page.dart';
import 'package:head_up_ui/views/weather_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final userInfoBloc = UserInfoBloc();
  final AuthService authService = AuthService();
  final WeatherService weatherService = WeatherServiceImpl();
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late UserInfo userInfo;
  final drawerImage =
      const AssetImage("assets/images/weathers/partly-cloud.jpeg");

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    userInfoBloc.close();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(color: Color(0xfff8f8fa)),
      child: BlocProvider<UserInfoBloc>(
        create: (context) => userInfoBloc..add(GetUserInfoEvent()),
        child: Scaffold(
            key: _scaffoldKey,
            drawerEnableOpenDragGesture: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                switch (state) {
                  case UserInfoInitial():
                    return Skeleton(
                        MyAppBar(UserInfo.skeleton_data, _scaffoldKey));
                  case LoadUserState():
                    userInfo = state.userInfo;
                    return MyAppBar(userInfo, _scaffoldKey);
                  default:
                    return Skeleton(
                        MyAppBar(UserInfo.skeleton_data, _scaffoldKey));
                }
              }),
            ),
            drawer: SafeArea(
              child: Drawer(
                shape: BorderDirectional(),
                child: Column(
                  children: <Widget>[
                    // Header: Menu list
                    Expanded(
                      child: ListView(
                        children: [
                          const DrawerHeader(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/weathers/partly-cloud.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Text('Menu',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 24)),
                          ),
                          ListTile(
                            leading: Icon(Icons.home),
                            title: Text('Home'),
                            onTap: () {
                              // Handle navigation to Home
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Settings'),
                            onTap: () {
                              // Handle navigation to Settings
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.info),
                            title: Text('About'),
                            onTap: () {
                              // Handle navigation to About
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(), // Divider to separate menu and user info
                    // Footer: User info and Sign out button
                    _userLogOutBloc()
                  ],
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height * 100,
              alignment: Alignment.center,
              child: PersistentTabView(
                navBarStyle: NavBarStyle.style3,
                handleAndroidBackButtonPress: true,
                backgroundColor: CupertinoColors.lightBackgroundGray,
                resizeToAvoidBottomInset: true,
                context,
                screens: _buildScreens(),
                items: _navBarsItems(),
                controller: _controller,
                stateManagement: true,
                animationSettings: const NavBarAnimationSettings(
                    navBarItemAnimation: ItemAnimationSettings(
                        duration: Duration(microseconds: 1000),
                        curve: Curves.decelerate),
                    screenTransitionAnimation: ScreenTransitionAnimationSettings(
                      animateTabTransition: true,
                      duration: Duration(milliseconds: 20),
                      screenTransitionAnimationType:
                          ScreenTransitionAnimationType.slide,
                    )),
                confineToSafeArea: true,
                navBarHeight: kBottomNavigationBarHeight,
                decoration: const NavBarDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 5.0,
                      spreadRadius: 0.5)
                ]),
              ),
            )),
      ),
    );
  }

  Widget _userLogOutBloc() {
    return BlocBuilder<UserInfoBloc, UserInfoState>(builder: (context, state) {
      switch (state) {
        case UserInfoInitial():
          return Skeleton(UserLogoutDrawer(UserInfo.skeleton_data));
        case LoadUserState():
          return UserLogoutDrawer(userInfo);
      }
      return Skeleton(UserLogoutDrawer(UserInfo.skeleton_data));
    });
  }

  List<Widget> _buildScreens() {
    return [DashboardPage(), LoaderPage()];
  }

  UserPage _userPage() {
    return UserPage();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    ScrollController _scrollController1 = ScrollController();
    ScrollController _scrollController2 = ScrollController();
    return [
      navBarItem(_scrollController1, context, Icon(Boxicons.bxs_dashboard)),
      navBarItem(_scrollController2, context, Icon(Boxicons.bx_calendar))
    ];
  }

  RouteAndNavigatorSettings _navigatorRoutes(BuildContext context) {
    return RouteAndNavigatorSettings(
      initialRoute: "/",
      routes: {
        "/dashboard": (final context) => DashboardPage(),
        "/alarm": (final context) => AlarmPage(),
        "/add-alarm": (final context) => Container(
              child: Text("Modal add alarm"),
            ),
        "/spinner": (final context) => LoaderPage(),
        "/user-info": (final context) => _userPage()
      },
    );
  }

  PersistentBottomNavBarItem navBarItem(
      ScrollController scrollController, BuildContext context, Icon icon) {
    return PersistentBottomNavBarItem(
        icon: icon,
        activeColorPrimary: const Color(0xff63cdff),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // scrollController: scrollController,
        routeAndNavigatorSettings: _navigatorRoutes(context));
  }

  PersistentBottomNavBarItem navBarButtonItem(BuildContext context, Icon icon) {
    return PersistentBottomNavBarItem(
        inactiveColorSecondary: Colors.white70,
        icon: icon,
        activeColorPrimary: const Color(0xff9fd5d7),
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.white,
        routeAndNavigatorSettings: _navigatorRoutes(context));
  }

  void setStateOutOfBuildPhrase(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fn();
      });
    });
  }

// Widget userAvatar(ImageProvider image) {
//   return GestureDetector(
//     onTap: () {
//       if (_scaffoldKey.currentState != null) {
//         _scaffoldKey.currentState!.openDrawer();
//       }
//     },
//     child: Container(
//       width: 30,
//       height: 30,
//       padding: EdgeInsets.all(2.0),
//       // Điều chỉnh độ dày viền
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: Colors.grey, // Màu viền
//           width: 1.0, // Độ dày của viền
//         ),
//       ),
//       child: CircleAvatar(
//         radius: 30.0, // Kích thước avatar
//         backgroundImage: image,
//       ),
//     ),
//   );
// }
}
