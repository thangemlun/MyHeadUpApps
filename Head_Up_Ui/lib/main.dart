import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/environment/app_properties.dart';
import 'package:head_up_ui/mvvm/note/note_grid_item_view.dart';
import 'package:head_up_ui/views/dashboard_module/dashboard_page.dart';
import 'package:head_up_ui/views/index_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localstorage/localstorage.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(AppProperties.APP_BOX);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDOscnoNh_QvUNGdrJyvA12fr_WhvIzoAM",
      authDomain: "head-up-644cb.firebaseapp.com",
      projectId: "head-up-644cb",
      storageBucket: "head-up-644cb.appspot.com",
      messagingSenderId: "213209070709",
      appId: "1:213209070709:web:8a5fa68330a54f2de60c3c",
      androidClientId: "213209070709-40a1mjd2efntvmoqs5mm9cevpn5en539.apps.googleusercontent.com",
      measurementId: "G-45CD6B0YTE"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Head Up',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            primarySwatch: Colors.blue,
          	textTheme: GoogleFonts.aBeeZeeTextTheme()
        ),
        home: InitializePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}