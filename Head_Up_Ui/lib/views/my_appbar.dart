import 'package:flutter/material.dart';
import 'package:head_up_ui/model/user_info.dart';

class MyAppBar extends StatefulWidget {
  final UserInfo userInfo;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MyAppBar(this.userInfo, this.scaffoldKey);

  @override
  State<StatefulWidget> createState() => MyAppBarState();
}

class MyAppBarState extends State<MyAppBar> {
  late final UserInfo userInfo;
  late final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.userInfo = widget.userInfo;
    this.scaffoldKey = widget.scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: userInfo.avatar.isNotEmpty ? userAvatar(NetworkImage(userInfo.avatar)) :
        userAvatar(AssetImage("assets/images/empty-avatar.png"))
    );
  }

  Widget userAvatar(ImageProvider image) {
    return GestureDetector(
      onTap: () {
        if (scaffoldKey.currentState != null) {
          scaffoldKey.currentState!.openDrawer();
        }
      },
      child: Container(
        width: 30,
        height: 30,
        padding: EdgeInsets.all(2.0),
        // Điều chỉnh độ dày viền
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey, // Màu viền
            width: 1.0, // Độ dày của viền
          ),
        ),
        child: CircleAvatar(
          radius: 30.0, // Kích thước avatar
          backgroundImage: image,
        ),
      ),
    );
  }
}
