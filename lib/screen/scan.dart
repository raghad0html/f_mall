import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'billScreen.dart';
import 'connect.dart';
import 'dataFalse.dart';
import 'datatrue.dart';

class MyHome extends StatefulWidget {
  final int id;
  const MyHome({Key? key, required this.id}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مسح الباركود'),
          backgroundColor: Colors.teal,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                //  Navigator.of(context).push(MaterialPageRoute(
                //  builder: (context) => const QRViewExample(),
                // ));
              },
              child: const Text('امسح QR'),
            ),
          ),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  final int id;

  const QRViewExample({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  /* var e;

  Future<Map<String, String>> getData() async {
    var _nowtime = DateTime.now();
  
    final response = await http.post(Uri.http('mall-app.com', "jtto/qr.php"),
        body: {
          'userid': widget.id.toString(),
          'qr': result!.code,
          'qrDate': _nowtime
        });
    if (response.statusCode == 200) {
      e = jsonDecode(response.body);
    }
    return e;
  }*/

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /*  if (result != null)
                      Text(
                          ' نوع الباركود ${describeEnum(result!.format)} البيانات: ${result!.code}')
                    else
                      const Text('امسح الكود'),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Text(' فلاش:${snapshot.data}');
                                },
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.flipCamera();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Text(
                                        'اتجاه الكاميرا ${describeEnum(snapshot.data!)}');
                                  } else {
                                    return const Text('تحميل');
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.pauseCamera();
                            },
                            child: const Text('توقيف',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.resumeCamera();
                            },
                            child: const Text('استمر',
                                style: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  /* String msg = "";
  String msg2 = "";
  */
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      
        result = scanData;
       controller.stopCamera();
        var res;
        var _nowtime = DateTime.now();
        var e = await http.post(Uri.http(new connn().getUrl(), 'jtto/qr.php'), body: {
          'userid': widget.id.toString(),
          'qr': result!.code.toString(),
          'qrDate': _nowtime.toString()
        });
        setState(()
         {
          res = jsonDecode(e.body);
         });
          if (res["qrType"] == "sticker") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DataTrue(
                    e: res,
                    point: res["points"],
                    totalpoint: res["ballancePonints"])));
          } else if (res["qrType"] == "invoice") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DataBill(
                      e: res,
                    )));
          } else  {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DataFalse()));
          }
       
      
      });
  
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

      /* var response = await http.post(Uri.http('mall-app.com', 'jtto/QR.php'),
          body: {
            'user_id': widget.id.toString(),
           'code': result!.code ,
          // 'nowtime':_nowtime
           });*/
      /*  setState(() {
        msg = jsonDecode(response.body);
      });
      if (msg == 'T') {
        var response2 = await http.post(
            Uri.http('mall-app.com', 'jtto/up_point.php'),
            body: {'user_id': widget.id.toString()});
        setState(() {
          msg2 = jsonDecode(response2.body);
        });
        controller.stopCamera();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => DataTrue()),
            (route) => true);
      } else {
        controller.stopCamera();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => DataFalse()),
            (route) => true);
      }*/
