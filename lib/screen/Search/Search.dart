import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      child: TextField(
                        controller: _search,
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: " ابحث عن",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                    onPressed: () {},
                    child: Text("البحث"),
                  ),
                  userMap != null
                      ? ListView(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(
                                  userMap!['image_url'],
                                ),
                              ),
                              title: Text(
                                userMap!['username'],
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(userMap!['email']),
                              trailing: Icon(Icons.chat, color: Colors.teal),
                            ),

                            ListTile(
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(
                                  userMap!['image_url'],
                                ),
                              ),
                              title: Text(
                                userMap!['shopname'],
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(userMap!['email']),
                              trailing: Icon(Icons.apartment_rounded, color: Colors.teal),
                            ),

                          ],
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
