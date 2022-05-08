import 'package:flutter/material.dart';

import 'enteredData.dart';


class buildName extends StatelessWidget {
  String? name;
  String? email;
  String? number;
  buildName(this.name,this.email,this.number);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: InkWell(
            child: ListTile(
              title: Text(
                'Name',
                style:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                name!,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.person,
                //   color: kPrimaryColor,
              ),
              trailing: Icon(
                Icons.edit,
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context, builder: (builder)=>EnteredData());
            },
          ),
        ),
        Divider(
          indent: 80,
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: InkWell(
            child: ListTile(
              title: Text(
                'E_mail',
                style:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                email!,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.email,
                // color: kPrimaryColor,
              ),
            ),
            onTap: () {
            },
          ),
        ),
        Divider(
          indent: 80,
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: InkWell(
            child: ListTile(
              title: Text(
                'Phone',
                style:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                number!,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.phone,
                //  color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
