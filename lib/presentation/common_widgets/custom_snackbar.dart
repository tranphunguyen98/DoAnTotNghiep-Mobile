import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class CustomSnackBar {
  static void showLoading(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Processing ...'),
              CircularProgressIndicator()
            ],
          ),
        ),
      );
  }

  static void hideLoading(BuildContext context) {
    Scaffold.of(context)..hideCurrentSnackBar();
  }

  static void failure(BuildContext context, {String msg = "Failure"}) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(
                msg,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
              )),
              Icon(Icons.error),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }

  static void success(BuildContext context, String msg) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Text(msg),
            ],
          ),
          backgroundColor: kColorPrimary,
        ),
      );
  }
}