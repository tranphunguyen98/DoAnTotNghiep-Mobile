import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/setting/setting_body.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Cài đặt"),
      ),
      body: SettingBody(),
    );
  }
}
