import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class DialogCompleteHabit extends StatefulWidget {
  final String title;

  const DialogCompleteHabit(this.title);

  @override
  _DialogCompleteHabitState createState() => _DialogCompleteHabitState();
}

class _DialogCompleteHabitState extends State<DialogCompleteHabit> {
  final TextEditingController _diaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop<String>(context, _diaryController.text);
        return true;
      },
      child: AlertDialog(
        title: Text(
          widget.title,
          style: kFontSemiboldBlack_16,
        ),
        content: SizedBox(
          width: 360.0,
          child: TextField(
            controller: _diaryController,
            style: kFontRegularBlack2_14,
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Hãy nói bất cứ những gì bạn nghĩ!",
              hintStyle: kFontRegularGray1_14,
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                      color: Colors.grey[300], width: 0.5) //This is Ignored,
                  ),
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
              Navigator.pop<String>(context, _diaryController.text);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _returnData() {}
}
