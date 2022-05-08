import 'package:flutter/material.dart';
import 'package:moll_app/LoginAndResetAndSignUp/registration/registration.dart';

import '../ui/shared/globals.dart';
import '../ui/widgets/wave_widget.dart';




class LoginForm extends StatefulWidget {
  final void Function(
          String email, String password, /* bool islogin, */ BuildContext ctx)
      _submitLogin;

  const LoginForm(this._submitLogin);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // form key
  final _formKey = GlobalKey<FormState>();


  String _email = "";
  String _password = "";

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String? errorMessage;

  //function
  void _submitLogin() {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      _email = emailController.text;
      _password = passwordController.text;
      _formKey.currentState?.save();
      widget._submitLogin(
          _email.trim(), _password.trim(), /* _isLogin, */ context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("الرجاء إدخل ايميلك الخاص");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("الرجاءإدخال الإيميل الصحيح");
          }
          return null;
        },
        onSaved: (val) => _email = val ?? '',
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "الإيميل",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (val) {
          if (val == null) {
            return "الرجاء إدخال 7 أحرف على الأقل";
          } else if (val.isEmpty || val.length < 7) {
            return "الرجاء إدخال 7 أحرف على الأقل";
          }
          return null;
        },
        onSaved: (val) => _password = val ?? '',
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "كلمة المرور",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            _submitLogin();

            },
          child: Text(
            "تسجيل الدخول",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(

          children:[
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
                    'تسجيل الدخول',
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
              padding: EdgeInsets.only(top: 250),
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 45),
                        emailField,
                        SizedBox(height: 25),
                        passwordField,
                        SizedBox(height: 35),
                        loginButton,
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("ليس لديك حساب؟"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text(
                                  "إنشاء حساب",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
              ],
        ),
      ),
    );
  }
}
