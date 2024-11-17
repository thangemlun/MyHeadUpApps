import 'package:flutter/material.dart';
import 'package:head_up_ui/login/login_page.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/services/auth_service.dart';
import 'package:head_up_ui/views/user_module/user_page.dart';

class UserLogoutDrawer extends StatelessWidget{

  final UserInfo userInfo;
  final authService = AuthService();

  UserLogoutDrawer(this.userInfo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
      				backgroundImage: userInfo.avatar.isNotEmpty ?
      				NetworkImage(userInfo.avatar) :
              AssetImage("assets/images/empty-avatar.png") as ImageProvider,),
            title: Text(getDisplayName()),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (context) => UserPage())
              );
            },
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              iconColor: Colors.red,
              overlayColor: Colors.red
            ),
            icon: Icon(Icons.logout),
            label: Text('Sign out', style: TextStyle(
              color: Colors.red
            ),),
            onPressed: () {
              // Handle sign out action
              authService.signOut().then((value) {
                Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage())
                );
              });
            },
          ),
        ],
      ),
    );
  }

  String getDisplayName() {
    return userInfo.displayName ?? userInfo.email;
  }

}