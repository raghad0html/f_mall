import 'package:flutter/material.dart';
import 'package:moll_app/local_storage/shared_prefernce_services.dart';
import 'package:moll_app/screen/welcome/signuporsignin.dart';



class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    LocalStorageService().firstTimeLogged = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Spacer(flex: 2),
              Image.asset("assets/icons/logo.png"),
              Spacer(flex: 1),
              Text(
                "مرحبا بكم في تطبيقنا",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: Text(
                  "تطبيق بريق الإعلان هو طريقة سهلة للتسوق في أي مكان.",
                  textAlign: TextAlign.center,
                  style:/* TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),*/
                  Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(),
                ),
              ),


              Spacer(flex: 3),
              FittedBox(
                child: TextButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninOrSignupScreen(),
                          ),
                        ),
                    child: Row(
                      children: [
                        Text(
                          "تخطي",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                              ),
                        ),
                        SizedBox(width: 20 / 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.8),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
