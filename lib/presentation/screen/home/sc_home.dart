import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/home/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Build Home");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
      ),
      drawer: MainDrawer(),
    );
  }
}
