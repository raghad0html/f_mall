import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moll_app/screen/homeScreen.dart';
import 'package:moll_app/screen/myCompetitionScreen.dart';


class WelcomeAfterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'بريق الإعلان',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.4, top: 10),
              child: Text(
                'اضف المتعة لتسوقك من خلال جمع النقاط\n'
                'والحصول على جوائز يومية واسبوعية وشهرية\n',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFfabc51)),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontFamily: GoogleFonts.cairo().fontFamily ,
                    )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                  ),

                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text(
                  'اختر المول',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff6f6f6f)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                        fontFamily: GoogleFonts.cairo().fontFamily ,
                        ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Mycompetition(
                              user_id: 1,
                            )),
                  );
                },
                child: Text(
                  'مسابقاتي',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
