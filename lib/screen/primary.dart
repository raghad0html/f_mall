import 'package:flutter/material.dart';
import 'package:moll_app/LoginAndResetAndSignUp/registration/registration.dart';
import 'package:moll_app/screen/MallScreen.dart';
import 'package:moll_app/screen/prizes.dart';

import '../../LoginAndResetAndSignUp/Login/login.dart';
import '../../LoginAndResetAndSignUp/Login/ui/shared/globals.dart';
import '../../LoginAndResetAndSignUp/Login/ui/widgets/wave_widget.dart';
import '../../component/primaryButton.dart';
import 'CompetitionScreen.dart';


class PrimaryScreen extends StatefulWidget {
  final int mall_id;
  final String mall_name;
   final String icon;

  const PrimaryScreen({Key? key, required this.mall_id, required this.mall_name, required this.icon}) : super(key: key);
  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
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
                   widget.mall_name,
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
                    'https://mall-app.com/jtto/img/'+widget.icon,
                    ),
                  ),
                  /* Text("JTTO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:  MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? Colors.white
                    :Colors.black,),),*/
                      Spacer(),
                  PrimaryButton(
                    color: Colors.teal,
                    text: " دخول المسابقة",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompetitionScreen(
                            mall_id: widget.mall_id,
                            mall_name: widget.mall_name,
                            
                          )
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  PrimaryButton(
                    color: Colors.teal,
                    text: " المتاجر",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MollScreen(
                            mall_id: widget.mall_id,
                            mall_name: widget.mall_name,
                            icon: widget.icon,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * 1.5),
                  PrimaryButton(
                    color: Colors.green,
                    text: "الجوائز",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrizeScreen(mall_id: widget.mall_id,mall_name: widget.mall_name,)
                         
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
