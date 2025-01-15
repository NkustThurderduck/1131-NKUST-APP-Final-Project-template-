import 'package:flutter/material.dart';
import 'tools.dart';

class all_character extends StatelessWidget {
  const all_character({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('全圖鑑'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        color: Colors.blue[50],
        child: const ExcelDataPage(),
      ),
    );
  }
}