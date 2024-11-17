import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:head_up_ui/login/login_page.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/services/auth_service.dart';
import 'package:head_up_ui/util/clip_board_util.dart';

class UserInfoComponent extends StatefulWidget {
  final UserInfo userInfo;

  UserInfoComponent(this.userInfo);

  @override
  State<StatefulWidget> createState() => UserInfoComponentState();
}

class UserInfoComponentState extends State<UserInfoComponent> {
  late UserInfo userInfo;
  late AuthService authService;

  @override
  void initState() {
    // TODO: implement initState
    userInfo = widget.userInfo;
    authService = AuthService();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant UserInfoComponent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    userInfo = widget.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    final _widthDevice = MediaQuery.of(context).size.width;
    final _heightDevice = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // header background
                Container(
                  height: _heightDevice * 0.4,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      gradient: const LinearGradient(
                          colors: [Color(0xffcfe7e8), Color(0xff9fd5d7)],
                          begin: Alignment.topCenter,
                          end: Alignment.center)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: _heightDevice * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        userInfo.avatar.isNotEmpty
                            ? buildAvatar(NetworkImage(userInfo.avatar))
                            : buildAvatar(AssetImage("assets/images/empty-avatar.png")),
                        SizedBox(
                          height: _heightDevice / 30,
                        ),
                        Text(
                          userInfo.displayName.isNotEmpty
                              ? userInfo.displayName
                              : userInfo.username,
                          style: TextStyle(
                              fontSize: getFontWidth(_widthDevice),
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                // Align(
                //     alignment: Alignment.topRight,
                //     child: btnSignOut(
                //         const Icon(Icons.exit_to_app_rounded,color: Colors.black54,))
                //     ),
              ],
            ),
            Container(
              color: Colors.white70,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SizedBox(
                    height: _heightDevice / 0.5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: _heightDevice / 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          infoChild(_widthDevice, CupertinoIcons.mail_solid, userInfo.email),
                          infoChild(_widthDevice, CupertinoIcons.phone, userInfo.mobilePhone),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoChild(double width, IconData icon, String data) {
    return Container(
      width: getFontWidth(width * ((width < 500) ? 42 : 25)),
      child: Column(
        children: [
          InkWell(
              child: btnCopyClipboard(
                  ListTile(
                    leading: Icon(
                      icon,
                      color: Colors.teal,
                      size: getFontWidth(width),
                    ),
                    title: Text(
                      data,
                      style: TextStyle(
                          fontSize: getFontWidth(width),
                          color: Colors.teal.shade900),
                    ),
                  ),
                  data))
        ],
      ),
    );
  }

  double getFontWidth(double width) {
    return width < 500 ? width / 20 : width * 0.02;
  }

  Widget btnCopyClipboard(Widget child, String data) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: MaterialButton(onPressed: (){
        if (data.isNotEmpty) {
          ClipBoardUtil.saveToClipBoard(context, data);
        }
      },
      child: child,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      color: Color(0xfff7f2fa),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),),
    );
  }

  Widget btnSignOut(Widget child) {
    return GestureDetector(
      onTap: () {
        authService.signOut().then((value) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage())
          );
        });
      },
      child: Container(
        padding: EdgeInsets.only(right: 10), // Padding để tạo khoảng trống
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.exit_to_app_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAvatar(ImageProvider image) {
    return
      Center(
        child: Stack(
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: image,
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                  child: InkWell(onTap: (){
                    print("Edit avatar");
                  }),
                ),
              ),
            ),
            Positioned(child: buildEditIcon(Color(0xff9fd5d7)),bottom: 0,right: 4,)
          ],
        ),
      );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 14,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
  
}
