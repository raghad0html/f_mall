import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class CameraUserPickImage extends StatefulWidget {
  final String imagePath;

  final void Function(File pickedImage) imagepickFn;

  const CameraUserPickImage(

      {
        Key? key,
        required this.imagePath,
        required this.imagepickFn,
      }) : super(key: key);

  @override
  _CameraUserPickImageState createState() => _CameraUserPickImageState();
}

class _CameraUserPickImageState extends State<CameraUserPickImage> {

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile =
    await _picker.pickImage(source: src);
    setState(() {
      if (pickedImageFile != null){
        _pickedImage = File(pickedImageFile.path);
        widget.imagepickFn(_pickedImage!);
      } else {
        print("لم يتم تحديد أي صورة");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final color = Colors.teal;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildCameraIcon(color, context),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = Image.asset(widget.imagePath);

    return ClipOval(
      child: Material(
        // color: Colors.blue,
        child:_pickedImage==null? Image.asset(
          widget.imagePath,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        ):Image.file(_pickedImage!,width: 150,height: 150,),
      ),
    );
  }

  Widget buildCameraIcon(Color color, BuildContext context) {



    return buildCircle(
      color: Colors.white,
      all: 3,
      child: InkWell(
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 20,
          ),
        ),
        onTap: () {
          var ad = AlertDialog(
            title: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "اختر صورة من:",
                style: TextStyle(),
              ),
            ),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: 150,
                child: Column(
                  children: [
                    Divider(color: Colors.grey),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.image,
                          color: Colors.teal,
                        ),
                        title: Text(
                          "المعرض",
                          style:  Theme.of(context).textTheme.subtitle2,
                        ),
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          //  Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.camera_alt,
                          color: Colors.teal,
                        ),
                        title: Text(
                          "الكاميرا",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          showDialog(context: context, builder: (builder) => ad);
        },
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

