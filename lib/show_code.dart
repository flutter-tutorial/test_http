import 'package:flutter/material.dart';
import 'code_view.dart';

class CodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Source code')),
      body: MyCodeView(filePath: 'lib/main.dart')
    );
  }
}