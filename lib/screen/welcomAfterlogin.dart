import 'package:flutter/material.dart';
import 'package:moll_app/LoginAndResetAndSignUp/registration/registration.dart';
import 'package:moll_app/screen/homeScreen.dart';
import 'package:moll_app/screen/myCompetitionScreen.dart';

import '../../LoginAndResetAndSignUp/Login/login.dart';
import '../../LoginAndResetAndSignUp/Login/ui/shared/globals.dart';
import '../../LoginAndResetAndSignUp/Login/ui/widgets/wave_widget.dart';
import '../../component/primaryButton.dart';



class welcomAfterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height - 200,
              color: Global.mediumBlue,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyboardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: Global.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'بريق الإعلان',
                    style: TextStyle(
                      color: Global.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Spacer(flex: 5),
                  Container(
                    height: 150,
                    child: Image.asset(
                      "assets/icons/logo.jpeg",
                    ),
                  ),
                  /* Text("JTTO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:  MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? Colors.white
                    :Colors.black,),),*/
                  Spacer(),
                  PrimaryButton(
                    color: Colors.teal,
                    text: "اختر المول",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(

                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * 1.5),
                  PrimaryButton(
                    color: Colors.green,
                    text: "مسابقاتي",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mycompetition(user_id: 1,)
                          
                            ),
                      );
                    },
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


