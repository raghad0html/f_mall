import 'package:flutter/material.dart';


class EnteredData extends StatefulWidget {

  @override
  _EnteredNameState createState() => _EnteredNameState();
// final String Name;
}

class _EnteredNameState extends State<EnteredData> {
  TextEditingController _controller=TextEditingController();

  String name='';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                height:25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.emoji_emotions_outlined,
                        )),*/
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "اكتب هنا...",
                          // border: InputBorder.none,
                          contentPadding: EdgeInsets.all(6),
                        ),
                        onSaved: (val) => name = val ?? '',

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      setState(() {
                        name=name;
                      });
                    }, child: Text("حفظ")),
                    SizedBox(width: 25,),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("خروج")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}