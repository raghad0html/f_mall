import 'package:flutter/material.dart';

class DataFalse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.error,
                size: 250,
                color: Colors.red,
              ),

            ),
            Text('لم يتم العثور على هذا الباركود ولم تحصل على نقاط ',style: TextStyle(fontSize: 25.0),),

          ],
        ),
      ),
    );
  }
}
