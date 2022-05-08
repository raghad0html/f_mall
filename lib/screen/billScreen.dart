
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataBill extends StatefulWidget {
  final  e;

  const DataBill({Key? key, required this.e}) : super(key: key);
  @override
  __DataBillState createState() => __DataBillState();
}

class __DataBillState extends State<DataBill> {
  String msg="";

  @override
  void initState() {
    // TODO: implement initState
    if (widget.e["status"] == "dublicate_invoice") {
      msg = "الفاتورة مكررة, تم استخدامها من قبل";
    } else if (widget.e["status"] == "store_not_subscribed") {
      msg = "الفاتورة لمتجر غير مشترك معنا في المسابقة";
    } else if (widget.e["status"] == "invoice_accepted") {
      msg = "الفاتورة صحيحة ,تم ترشيحك للتّقدم للمسابقة وجمع النقاط ";
    } else if (widget.e["status"] == "invoice_amount_less_than_allowed") {
      msg = "قيمة الفاتورة أقل من الحد المخول للترشح المسابقة ";
    }
    else{

    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int priceFull = widget.e["cost"].hashCode;
    String name = widget.e["seller"];
    int taxNum = widget.e["taxNum"];
    int tax = widget.e["vat"].hashCode;
    String date = widget.e["date"];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text('بيانات الفاتورة:'),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "تفاصيل الفاتورة",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('اسم البائع:   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('الرقم الضريبي:   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$taxNum',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('التاريخ:   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$date',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('مبلغ الفاتورة مع الضريبة:   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$priceFullريال ',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('الضريبة:   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$tax ريال ',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
               SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('الحالة   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    msg,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
