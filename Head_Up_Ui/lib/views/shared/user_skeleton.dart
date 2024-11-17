import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/views/user_module/user_info_component.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserSkeleton extends StatelessWidget {

  List<UserInfo> userTmp = List
      .filled(1, UserInfo(0,"abc@mail.com", "firstName", "lastName", "123456780","displayName", "", "", false));

  final bool enabled;

  UserSkeleton(this.enabled);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Skeletonizer(
      enabled: enabled,
      effect: ShimmerEffect(),
      child: UserInfoComponent(userTmp.first),);
  }

}