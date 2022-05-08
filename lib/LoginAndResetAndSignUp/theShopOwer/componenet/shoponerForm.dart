
import 'package:flutter/material.dart';


class ShopOwnerform extends StatefulWidget {
  final void Function(
      String shopname,
      String email,
    //  String Cardtypr,
      String numberDays,
      String password,
      String shopCentrName,
      BuildContext ctx) _submitDataForm;
  final bool _isloading;

  const ShopOwnerform(this._submitDataForm, this._isloading);

  @override
  _ShopOwnerformState createState() => _ShopOwnerformState();
}

class _ShopOwnerformState extends State<ShopOwnerform> {
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _shopname = "";
  String _shopcenterName = "";
 // String _Cardtype = "";
  String _password = "";
  String _Number_of_days_of_subscription = "";

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      _email ="aaa@aa.ss"; //emailEditingController.text;
      _shopname = shopnameEditingController.text;
      _shopcenterName = shopcenterEditingController.text;
    //  _Cardtype = CardtypeEditingController.text;
      _password = passwordEditingController.text;
      _Number_of_days_of_subscription = subscriptionEditingController.text;
      _formKey.currentState?.save();
      widget._submitDataForm(
          _shopname.trim(),
          _email.trim(),
       //   _Cardtype.trim(),
          _Number_of_days_of_subscription.trim(),
          _password.trim(),
          _shopcenterName.trim(),
          context);
    }
  }

  String? _selectLetter;
  List _LetterList = [
    '1000:500ريال',
    '2000:1000ريال',
    '3000:1500ريال',
    '4000:2000ريال'

  ];
  final shopnameEditingController = new TextEditingController();
  final CardtypeEditingController = new TextEditingController();
  final subscriptionEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final shopcenterEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final shopNameField = TextFormField(
        autofocus: false,
        controller: shopnameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("لا يمكن أن يكون اسم المتجر فارغًا");
          }
          if (!regex.hasMatch(value)) {
            return ("أدخل اسمًا صالحًا (3 أحرف على الأقل)");
          }
          return null;
        },
        onSaved: (val) => _shopname = val ?? '',
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
          hintText: "اسم المتجر",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final shopcenterNameField = TextFormField(
        autofocus: false,
        controller: shopcenterEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("اسم مركز التسوق لا يمكن أن يكون فارغا");
          }
          if (!regex.hasMatch(value)) {
            return ("أدخل اسمًا صالحًا (3 أحرف على الأقل)");
          }
          return null;
        },
        onSaved: (val) => _shopcenterName = val ?? '',
        textInputAction: TextInputAction.next,
        // cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.apartment_rounded,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "اسم مركز التسوق",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
   /* final CardtypeField = TextFormField(
        autofocus: false,
        controller: CardtypeEditingController,
        keyboardType: TextInputType.name,
        validator: (val) {
          if (val == null) {
            return "please enter at least 1 number of points";
          } else if (val.isEmpty || val.length < 1) {
            return "please enter at least 1 number of points";
          }
          return null;
        },
        onSaved: (val) => _Cardtype = val ?? '',
        textInputAction: TextInputAction.next,
        // cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.add_outlined,
            color: Colors.teal,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Number of points",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));*/

    final SubField = TextFormField(

        autofocus: false,
        controller: subscriptionEditingController,
        keyboardType: TextInputType.name,
        validator: (val) {

             if ( val!.length>1 ) {
               return ("الرجاء إدخال 7 أيام على الأقل للاشتراك");
             }
             return null;
        },

         /* if (!RegExp("^[7]")
              .hasMatch(val!) || val.length>1|| val==null ) {
            return ("الرجاء إدخال 7 أيام على الأقل للاشتراك");
          }
          return null;
        },*/
        onSaved: (val) => _Number_of_days_of_subscription = val ?? '',
        textInputAction: TextInputAction.next,
        // cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.add_outlined,
            color: Colors.teal,
          ), //color: kSecondaryColor,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "أيام الاشتراك",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
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
            return ("الرجاء إدخال الإيميل الصحيح");
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
          hintText: "ايميل مالك المتجر",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (val) {
          if (val == null) {
            return "الرجاء إدخال 7 محارف على الأقل";
          } else if (val.isEmpty || val.length < 7) {
            return "الرجاء إدخال 7 محارف على الأقل";
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

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            _submit();
          },
          child: Text(
            "انشاء حساب",
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
              color: Colors.teal,
              //color:MediaQuery.of(context).platformBrightness == Brightness.light?darkTheme:LightTheme,
            ),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
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
                      shopNameField,
                      SizedBox(height: 18),
                      shopcenterNameField,
                      SizedBox(height: 18),
                      emailField,
                      SizedBox(height: 18),
                      passwordField,
                      SizedBox(height: 18),
                      SubField,
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("باقة النقاط",
                                  style: Theme.of(context).textTheme.subtitle1),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButton(
                                    value: _selectLetter,
                                    items: _LetterList.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item,
                                            style: TextStyle(fontSize: 12.8)),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _selectLetter = newVal as String?;
                                      });
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(),
                      if (widget._isloading) CircularProgressIndicator(),
                      if (!widget._isloading) signUpButton,
                    ],
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
