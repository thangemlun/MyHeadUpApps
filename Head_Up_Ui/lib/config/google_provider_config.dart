
import 'package:google_sign_in/google_sign_in.dart';

class GoogleProviderUtil{
  static GoogleProviderUtil? _instance = null;
  late GoogleSignIn googleSignIn;

  GoogleProviderUtil(){
    googleSignIn = GoogleSignIn(
      signInOption: SignInOption.games,
      forceCodeForRefreshToken: true,
      clientId: "64273882526-d38v0dkdstrk3gmmg2jslleiikgmdi6t.apps.googleusercontent.com",
      scopes:['email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/userinfo.email',]
    );
  }

  static GoogleProviderUtil? getInstance() {
    // singleton check instance null then init constructor
      if (null == _instance) {
        _instance = GoogleProviderUtil();
      }
      return _instance;
  }

}