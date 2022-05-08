import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moll_app/mall_sdk.dart';
import 'package:moll_app/screen/MallScreen.dart';
import 'package:moll_app/screen/prizes.dart';

import '../../LoginAndResetAndSignUp/Login/ui/shared/globals.dart';
import '../../LoginAndResetAndSignUp/Login/ui/widgets/wave_widget.dart';
import '../../component/primaryButton.dart';
import 'CompetitionScreen.dart';


class PrimaryScreen extends StatefulWidget {
  final int mall_id;
  final String mall_name;
   final String icon;

  const PrimaryScreen({Key? key, required this.mall_id, required this.mall_name, required this.icon}) : super(key: key);
  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Stack(
            children: [
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
                     widget.mall_name,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(flex: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: MallSdk.imageUrl + widget.icon,
                        alignment: Alignment.center,
                        placeholder: (s, e) => Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(color: Colors.teal,),
                          ),
                        ),
                        errorWidget: (e, r, t) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                    /* Text("JTTO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      :Colors.black,),),*/
                        Spacer(),
                    PrimaryButton(
                      color: Colors.teal,
                      text: " دخول المسابقة",
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompetitionScreen(
                              mall_id: widget.mall_id,
                              mall_name: widget.mall_name,

                            )
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                    PrimaryButton(
                      color: Colors.teal,
                      text: " المتاجر",
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MollScreen(
                              mall_id: widget.mall_id,
                              mall_name: widget.mall_name,
                              icon: widget.icon,
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * 1.5),
                    PrimaryButton(
                      color: Colors.green,
                      text: "الجوائز",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrizeScreen(mall_id: widget.mall_id,mall_name: widget.mall_name,)

                              ),
                        );
                      },
                    ),
                    Spacer(flex: 2),
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
