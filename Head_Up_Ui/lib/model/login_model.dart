import 'package:google_sign_in/google_sign_in.dart';

class LoginModel {
  final String accessToken;
  final String idToken;
  late String avatar;
  late String name;

  LoginModel(this.accessToken, this.idToken, this.name, this.avatar);

  factory LoginModel.fromGGAuthen(GoogleSignInAccount ggUser, GoogleSignInAuthentication authentication) {
    String? accessToken = authentication?.accessToken;
    String? idToken = authentication.idToken ?? "" ;
    String? avatar = ggUser.photoUrl ?? "";
    String? name = ggUser.displayName ?? "";
    return LoginModel(accessToken!, idToken!, name, avatar);
  }
}