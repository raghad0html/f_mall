import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';


class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagepickFn;
  UserImagePicker(this.imagepickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile =
    await _picker.getImage(source: src, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile != null){
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagepickFn(_pickedImage!);
    } else {
      print("لم يتم تحديد أي صورة");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage:
            _pickedImage != null ? FileImage(_pickedImage!) : null,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => _pickImage(ImageSource.camera),

                child:Row(
                  children:[
                    Icon(Icons.photo_camera_outlined,//color: kSecondaryColor,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'أضف صورة من الكميرا',
                      textAlign: TextAlign.center,
                      //  style: TextStyle(color: kSecondaryColor),
                    ),
                  ], ),
              ),
              TextButton(
                //  color: kPrimaryColor,
                onPressed: () => _pickImage(ImageSource.gallery),
                //  icon: Icon(Icons.image_outlined,color: Colors.white,),
                child: Row(
                  children: [
                    Icon(Icons.image_outlined,//color: kSecondaryColor,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'أضف صورة من المعرض',
                      textAlign: TextAlign.center,
                      // style: TextStyle(color: kSecondaryColor),
                    ),
                  ],),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
