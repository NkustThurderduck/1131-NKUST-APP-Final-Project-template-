import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'character_page.dart';

/// 讀取 Excel 檔案並返回指定的表格數據
/// [filePath] - Excel 檔案路徑
/// [sheetName] - 可選，指定需要讀取的表格名稱
Future<List<List<String>>> readExcelFile(String filePath, {String? sheetName}) async {
  try {
    // 異步讀取檔案
    ByteData file = await rootBundle.load(filePath);
    var bytes = file.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    List<List<String>> data = [];

    // 獲取特定的表格數據
    if (sheetName != null && excel.tables.containsKey(sheetName)) {
      var sheet = excel.tables[sheetName];
      if (sheet != null) {
        for (var row in sheet.rows) {
          data.add(row.map((cell) => cell?.value?.toString() ?? '').toList());
        }
      }
    } else {
      // 如果未指定表格名稱，讀取所有表格
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet != null) {
          for (var row in sheet.rows) {
            data.add(row.map((cell) => cell?.value?.toString() ?? '').toList());
          }
        }
      }
    }

    return data;
  } catch (e) {
    // 捕獲並返回錯誤
    print('讀取 Excel 檔案失敗：$e');
    return [];
  }
}


void showImagePath(String dataPlace) {
  String imagePath = 'assets/img/皇室卡牌資訊/$dataPlace.png';
  print('Image path: $imagePath');
}



class ExcelDataPage extends StatefulWidget {
  const ExcelDataPage({super.key});

  @override
  _ExcelDataPageState createState() => _ExcelDataPageState();
}

class _ExcelDataPageState extends State<ExcelDataPage> {
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadExcelData();
  }

  Future<void> _loadExcelData() async {
    String filePath = 'assets/clashroyale.xlsx'; // 更新為你的文件路徑
    List<List<dynamic>> data = await readExcelFile(filePath);
    if (data.isNotEmpty) {
      data.removeAt(0); // 刪除第一份資料
    }
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _data.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: _data.length,
      itemBuilder: (context, index) {
        var dataPlace = '${_data[index][2]}卡/${_data[index][1]}';
        showImagePath(dataPlace);
        return GestureDetector(
          onTap: () {
            // Remove the first item and pass the rest of the list
            List<String> updatedData = List.from(_data[index]);
            updatedData.removeAt(0); // Remove the first item

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => character_page(Data: updatedData),
              ),
            );
          },
          child: Image.asset('assets/img/皇室卡牌資訊/$dataPlace.png'),
        );
      },
    );
  }
}