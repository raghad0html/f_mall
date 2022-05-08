import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DataTrue extends StatefulWidget {
  final int point;
  final int totalpoint;
  final  e;
  const DataTrue(
      {Key? key,
      required this.point,
      required this.totalpoint,
      required this.e})
      : super(key: key);
  @override
  State<DataTrue> createState() => _DataTrueState();
}

class _DataTrueState extends State<DataTrue> {
  String msg = "";
  var p;
  var totalPoints;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  @override
  void initState() {
    // _controller = VideoPlayerController.network(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    p = widget.point;
    totalPoints = widget.totalpoint;
    if (widget.e["status"] == "unknown_shop") {
      msg = widget.e['msg'];
    } else if (widget.e["status"] == "no_invoice_for_this_shop_for_this_user") {
      msg = widget.e['msg'];
    } else if (widget.e["status"] == "no_invoices_not_claimed_points")
     {
      msg =
          widget.e['msg'];
      }
     else if (widget.e["status"] == "points_claimed") 
        {
            msg =widget.e['msg'];

                       if (p == 2) {
                        _controller = VideoPlayerController.asset("assets/icons/video2.mp4");
                      } else if (p == 5) {
                        _controller = VideoPlayerController.asset("assets/icons/video5.mp4");
                      } else if (p == 8) {
                        _controller = VideoPlayerController.asset("assets/icons/video8.mp4");
                      } else if (p == 12) {
                        _controller = VideoPlayerController.asset("assets/icons/video12.mp4");
                      }
       }
     else if (widget.e["status"] == "qr_scans_limit_for_this_shop_reached") {
      msg = widget.e['msg']+" سيعاد التفعيل بعد" +widget.e["timeToReActivateQR"];
    } else {
      msg = widget.e["cusText"];
    }

   

    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.setLooping(true);
    _controller!.setVolume(1.0);
    _controller!.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'مجموع النقاط : $totalPoints',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'الحالة : ' + msg,
                    style: TextStyle(fontSize: 25.0),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller!.value.isPlaying) {
                _controller!.pause();
              } else {
                _controller!.play();
              }
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
// Column(
//
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Center(
// child: Icon(
// Icons.check_circle,
// size: 50,
// color: Colors.green,
// ),
// ),
// SizedBox(
// height: 20.0,
// ),
// Image(
// image: AssetImage('assets/icons/win.gif'),
// ),
// SizedBox(
// height: 20.0,
// ),
// Text(
// 'you won 20 points go to next moll',
// style: TextStyle(fontSize: 25.0),
// ),
// ],
// ),
