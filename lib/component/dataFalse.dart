
import 'package:flutter/material.dart';

class DataFalse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('False'),
      ),
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
              SizedBox(
                        height: 200,
                        child: Text('Sorry !!!')

              ) ],
      ),
    );
  }
}
