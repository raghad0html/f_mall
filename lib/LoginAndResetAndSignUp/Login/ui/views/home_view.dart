
import 'package:flutter/material.dart';
import '../../../../screen/TabBar_Screen.dart';
import '../shared/globals.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';
import '../widgets/wave_widget.dart';


class LoginView extends StatefulWidget {
  final void Function(String email, String password, /* bool islogin, */ BuildContext context)
      submitLogi;

   LoginView(this.submitLogi);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginView> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _email = "";
  String _password = "";

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String? errorMessage;

  //function
  void _submitLogin(context) {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      _email = emailController.text;
      _password = passwordController.text;
      _formKey.currentState?.save();
      widget.submitLogi(
          _email.trim(), _password.trim(), /* _isLogin, */ context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(
        children: <Widget>[
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
                  'Login',
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
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 150,
                  child: Image.asset(
                    "assets/icons/moll.png",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  hintText: 'Email',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Password',
                      prefixIconData: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                ButtonWidget(
                  onTap: () {
                    //w
                   // Navigator.push(context, MaterialPageRoute(builder: (builder)=>TabBar_Screen(user_id:1,)));
                    _submitLogin(context);
                  },
                  title: 'Login',
                  hasBorder: false,
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
