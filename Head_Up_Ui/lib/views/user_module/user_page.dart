import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:head_up_ui/bloc/user_info_bloc.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/services/impl/user_service_impl.dart';
import 'package:head_up_ui/views/shared/user_skeleton.dart';
import 'package:head_up_ui/views/user_module/user_info_component.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final userInfoBloc = UserInfoBloc();
  late bool isLoading = true;
  late UserInfo? userInfo;

  final _formEditUserKey = GlobalKey<FormBuilderState>();
  var _firstNameKey = GlobalKey<FormBuilderFieldState>();
  var _lastNameKey = GlobalKey<FormBuilderFieldState>();
  var _mobileKey = GlobalKey<FormBuilderFieldState>();
  bool isEditable = false;
  final userService = UserServiceImpl();

  @override
  void initState() {
    userInfoBloc.eventController.sink.add(GetUserInfoEvent());
  }

  void setFormEditable() {
    setState(() {
      isEditable = (userInfo!= null);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _widthDevice = MediaQuery.of(context).size.width;
    var _heightDevice = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
        // Nút quay lại tự động có sẵn trong AppBar
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          shape: CircleBorder(eccentricity: 0.8),
          onPressed: !isEditable ? null : () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  width: _widthDevice,
                  height: _heightDevice * 0.5,
                  child: Stack(
                    children: [
                      const Align(
                          alignment: Alignment.topCenter,
                          child: Text('Edit profile',
                          style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.w500))),
                      Align(
                        alignment: Alignment.center,
                        child: UserForm(),
                        ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: !isEditable ? Colors.grey : const Color(0xff9fd5d7),
          child: const Icon(
            CupertinoIcons.pencil,
            color: Colors.white70,
          ),
        ),
      ),
      body: StreamBuilder<UserInfoState>(
        stream: userInfoBloc.stateController.stream,
        initialData: userInfoBloc.state,
        builder: (context, AsyncSnapshot<UserInfoState> snap) {
          var result;
          if (snap.data is LoadUserState) {
            result = snap.data;
            userInfo = result.userInfo;
            // make edit profile enable
            setStateOutOfBuildPhrase(() {
              isLoading = false;
              setFormEditable();
            });
          } else {
            setStateOutOfBuildPhrase(() {
              isLoading = true;
            });
          }
          return (!isLoading && result != null) ?
          RefreshIndicator(color: Color(0xff9fd5d7), backgroundColor: Colors.transparent, child: Container(
              alignment: Alignment.center,
              child: UserInfoComponent(result.userInfo)),
              onRefresh: () async {
                userInfoBloc.eventController.sink.add(LoadUserEvent());
            		userInfoBloc.eventController.sink.add(GetUserInfoEvent());
              }) :
          UserSkeleton(isLoading);
        },
      ),
    );
  }

  Widget UserForm() {
    return FormBuilder(
        key: _formEditUserKey,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilderTextField(
                  name: "mobilePhone",
                  keyboardType: TextInputType.phone,
                  decoration:
                  const InputDecoration(labelText: 'Mobile Phone'),
                  enabled: true,
                  key: _mobileKey,
                  initialValue: userInfo?.mobilePhone ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.phoneNumber(regex: RegExp(r'^\+?([0-9]{1,4})?([0-9]{7,15})$')),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilderTextField(
                  name: "firstName",
                  decoration:
                  const InputDecoration(labelText: 'First Name'),
                  enabled: true,
                  key: _firstNameKey,
                  initialValue: userInfo?.firstName ?? '',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilderTextField(
                  name: "lastName",
                  enabled: true,
                  decoration:
                  const InputDecoration(labelText: 'Last Name'),
                  key: _lastNameKey,
                  initialValue: userInfo?.lastName ?? '',
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () async {
                    if (_formEditUserKey.currentState!.isValid) {
                      Map<String, dynamic> formBody = _formEditUserKey.currentState!.instantValue;
                      Map<String, dynamic> rqBody = Map();
                      rqBody['mobilePhone'] = formBody['mobilePhone'];
                      rqBody['firstName'] = formBody['firstName'];
                      rqBody['lastName'] = formBody['lastName'];
                    	rqBody['id'] = userInfo?.id;
                      await userService.updateUserInfo(context, rqBody);

                      // This is code for closing bottom modal
                      Navigator.pop(context);

                      userInfoBloc.eventController.sink.add(GetUserInfoEvent());
                    }
                	},
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.black12,
                          style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xffcfe7e8),
                  child: const Text("Submit",style: TextStyle(
                    color: Colors.teal,
                  ),)),
              )
            ],
          ),
        ));
  }

  void setStateOutOfBuildPhrase(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fn();
      });
    });
  }

}
