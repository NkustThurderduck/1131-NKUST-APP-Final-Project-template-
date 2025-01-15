import 'package:flutter/material.dart';
import 'tools.dart'; // 確保導入定義 readExcelFile 函數的文件

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel File Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExcelTestPage(),
    );
  }
}

class ExcelTestPage extends StatefulWidget {
  const ExcelTestPage({super.key});

  @override
  _ExcelTestPageState createState() => _ExcelTestPageState();
}

class _ExcelTestPageState extends State<ExcelTestPage> {
  List<List<dynamic>> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExcelData();
  }

  Future<void> _loadExcelData() async {
    String filePath = 'assets/clashroyale.xlsx'; // 更新為你的文件路徑
    List<List<dynamic>> data = await readExcelFile(filePath);
    setState(() {
      _data = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel File Test'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_data[index].toString()),
                );
              },
            ),
    );
  }
}