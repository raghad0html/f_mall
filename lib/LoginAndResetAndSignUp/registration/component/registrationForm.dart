import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theShopOwer/shopOwner.dart';
import 'CameraUserPickImage.dart';

class RegistrationForm extends StatefulWidget {
  final void Function(
      String email,
      String password,
      String username,
      String number,
      File image ,
      BuildContext ctx) _submitAuthForm;

  const RegistrationForm(this._submitAuthForm);
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _number = "";
  String _username = "";
  File? _userImageFile;
  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  //function
  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
 /*   if ( //!_isLogin &&
        _userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Directionality(
            textDirection:TextDirection.rtl,
            child: Text("الرجاء اختيار صورة.")),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }*/
    if (isValid) {
      _formKey.currentState?.save();
      _email = emailEditingController.text;
      _password = passwordEditingController.text;
      _number = numberEditingController.text;
      _username = firstNameEditingController.text;
      widget._submitAuthForm(_email.trim(), _password.trim(), _username.trim(),
          _number.trim(),
          _userImageFile!, context);
    }
  }

  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final numberEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final userNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("اسم المستخدم لا يمكن أن يكون فارغا");
          }
          if (!regex.hasMatch(value)) {
            return ("أدخل اسمًا صالحًا (3 أحرف على الأقل)");
          }
          return null;
        },
        onSaved: (val) => _username = val ?? '',
        textInputAction: TextInputAction.next,
        // cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "اسم المستخدم",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("الرجاء إدخال ايميلك الخاص");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("الرجاء ادخال الايميل الصحيح");
          }
          return null;
        },
        onSaved: (val) => _email = val ?? '',
        // cursorColor: kSecondaryColor,
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
          hintText: "الايميل",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (val) {
          if (val == null) {
            return "الرجاء إدخال 7 محارف على الأقل";
          } else if (val.isEmpty || val.length < 7) {
            return "الرجاء إدخال 7 محارق على الأقل";
          }
          return null;
        },
        onSaved: (val) => _password = val ?? '',
        // cursorColor: kSecondaryColor,
        textInputAction: TextInputAction.next,
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

    final numberField = TextFormField(
        inputFormatters:<TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('^[0|9][0-9]*')),
        ],
        autofocus: false,
        controller: numberEditingController,
        validator: (val) {
          if (val == null) {
            return "الرجاء إدخال رقمك";
          } else if (val.isEmpty || val.length < 10) {
            return "الرجاء إدخال ما لا يقل عن 10 أرقام";
          }
          return null;
        },
        onSaved: (val) => _number = val ?? '',
        // cursorColor: kSecondaryColor,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "رقم الهاتف",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
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
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
           _submit();
         //  Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomeScreen()));

          },
          child: Text(
            "إنشاء الحساب",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light?LightTheme:darkTheme,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
              //color:MediaQuery.of(context).platformBrightness == Brightness.light?darkTheme:LightTheme,
            ),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                // color:MediaQuery.of(context).platformBrightness == Brightness.light?LightTheme:darkTheme,
                child: Padding(
                  padding: const EdgeInsets.all(29.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CameraUserPickImage(
                          imagepickFn: _pickedImage,
                          imagePath: 'assets/icons/person.png',
                        ),
                        SizedBox(height: 16),
                        emailField,
                        /*SizedBox(height: 20),
                        secondNameField,
                        SizedBox(height: 20),
                        emailField,*/
                        SizedBox(height: 18),
                        userNameField,
                        SizedBox(height: 18),
                        passwordField,
                        SizedBox(height: 18),
                        numberField,
                        SizedBox(height: 18),
                        signUpButton,
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("إذا كنت مالك متجر"),
                              SizedBox(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShopOwner()));
                                },
                                child: Text(
                                  " أنشئ حساب متجر",
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
        ),
      ),
    );
  }
}
