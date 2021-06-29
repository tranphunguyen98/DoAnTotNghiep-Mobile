import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totodo/utils/my_const/font_const.dart';

const String kCompletedHabitDialogTextKey = 'text';
const String kCompletedHabitDialogImagesKey = 'images';

class DialogCompleteHabit extends StatefulWidget {
  final String title;

  const DialogCompleteHabit(this.title);

  @override
  _DialogCompleteHabitState createState() => _DialogCompleteHabitState();
}

class _DialogCompleteHabitState extends State<DialogCompleteHabit> {
  final TextEditingController _diaryController = TextEditingController();
  final picker = ImagePicker();
  final List<String> images = [];
  String messageError;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop<Map<String, Object>>(context, {
          kCompletedHabitDialogTextKey: _diaryController.text,
          kCompletedHabitDialogImagesKey: images,
        });
        return true;
      },
      child: AlertDialog(
        title: Text(
          widget.title,
          style: kFontSemiboldBlack_16,
        ),

        insetPadding: EdgeInsets.symmetric(horizontal: 32),
        // contentPadding: EdgeInsets.a,
        content: SizedBox(
          width: 360.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _diaryController,
                  style: kFontRegularBlack2_14,
                  minLines: 3,
                  maxLines: 3,
                  onChanged: (value) {
                    if (value.isNotEmpty && messageError != null) {
                      setState(() {
                        messageError = null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Hãy nói bất cứ những gì bạn nghĩ!",
                    hintStyle: kFontRegularGray1_14,
                    errorText: messageError,
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Colors.grey[300],
                            width: 0.5) //This is Ignored,
                        ),
                  ),
                ),
                _buildImage(),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              if (_diaryController.text.isNotEmpty) {
                Navigator.pop<Map<String, Object>>(context, {
                  kCompletedHabitDialogTextKey: _diaryController.text,
                  kCompletedHabitDialogImagesKey: images,
                });
              } else {
                setState(() {
                  messageError = 'Nội dung không được rỗng';
                });
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Wrap(
          spacing: 8.0,
          children: _getWidgetListMotivationImage(),
        ));
  }

  List<Widget> _getWidgetListMotivationImage() {
    final List<Widget> widgetList = [];
    const double imageSize = 80.0;

    if (images.isNotEmpty) {
      widgetList.addAll(images
          .map(
            (image) => Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.file(
                      File(image),
                      height: imageSize,
                      width: imageSize,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      _onTap(image);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList());
    }

    widgetList.add(
      GestureDetector(
        onTap: _getImage,
        child: Container(
          height: imageSize,
          width: imageSize,
          margin: const EdgeInsets.only(bottom: 8.0, top: 8, right: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(color: Colors.grey[300]),
          ),
          child: Icon(
            Icons.add_photo_alternate,
            size: 24,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
    return widgetList;
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        images.add(imageFile.path);
      }
    });
  }

  void _onTap(String image) {
    setState(() {
      images.remove(image);
    });
  }

  void _returnData() {}
}
