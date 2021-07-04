import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class DialogCheckInHabit extends StatefulWidget {
  final String title;

  const DialogCheckInHabit({Key key, this.title}) : super(key: key);

  @override
  _DialogCheckInHabitState createState() => _DialogCheckInHabitState();
}

class _DialogCheckInHabitState extends State<DialogCheckInHabit> {
  final TextEditingController _numberController = TextEditingController();
  String messageError;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop<int>(
            context,
            int.parse((_numberController.text?.isNotEmpty ?? false)
                ? _numberController.text
                : "0"));
        return true;
      },
      child: AlertDialog(
        title: Text(
          widget.title,
          style: kFontSemiboldBlack_16,
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 32),
        // contentPadding: EdgeInsets.a,
        content: TextField(
          controller: _numberController,
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
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            hintText: "Nhập số lượng",
            hintStyle: kFontRegularGray1_14,
            errorText: messageError,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: Colors.grey[300], width: 0.5) //This is Ignored,
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
              if (_numberController.text.isNotEmpty) {
                Navigator.pop<int>(
                    context,
                    int.parse((_numberController.text?.isNotEmpty ?? false)
                        ? _numberController.text
                        : "0"));
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
}
