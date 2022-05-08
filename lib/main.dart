import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moll_app/local_storage/shared_prefernce_services.dart';
import 'package:moll_app/screen/welcome/get_data_user_page.dart';
import 'package:moll_app/screen/welcome/signuporsignin.dart';
import 'package:moll_app/screen/welcome/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.teal),
          fontFamily: GoogleFonts.cairo().fontFamily,
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
          )),
        ),
        home: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: (LocalStorageService().firstTimeLogged ?? false)
                ? ((LocalStorageService().login ?? false)
                    ? GetDataUserPage()
                    : SigninOrSignupScreen())
                : WelcomeScreen())
        // WelcomeScreen(),
        );
    //WelcomeScreen(),
  }
}
