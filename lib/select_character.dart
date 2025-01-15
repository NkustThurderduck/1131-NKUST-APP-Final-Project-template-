import 'package:flutter/material.dart';
import 'tools.dart';
import 'character_page.dart';

class select_character extends StatefulWidget {
  const select_character({super.key});

  @override
  _select_characterState createState() => _select_characterState();
}

class _select_characterState extends State<select_character> {
  String? selectedRarity;
  String? selectedType;
  String? selectedElixirCost;
  List<List<dynamic>> searchResults = [];

  // 定義選項
  final List<String> rarityOptions = ['普通', '稀有', '史詩', '傳奇','英雄'];
  final List<String> typeOptions = ['軍隊', '建築', '法術'];
  final List<String> elixirCostOptions = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  // 搜尋功能
  Future<void> _search() async {
    String filePath = 'assets/clashroyale.xlsx';
    List<List<dynamic>> data = await readExcelFile(filePath);

    if (data.isNotEmpty) {
      data.removeAt(0); // 刪除第一份資料
    }

    List<List<dynamic>> results = data.where((row) {
      bool matchesRarity = selectedRarity == null || row[2] == selectedRarity;
      bool matchesType = selectedType == null || row[3] == selectedType;
      bool matchesElixirCost = selectedElixirCost == null || row[4] == selectedElixirCost;
      return matchesRarity && matchesType && matchesElixirCost;
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  // 清空下拉選單
  void _clearSelections() {
    setState(() {
      selectedRarity = null;
      selectedType = null;
      selectedElixirCost = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜尋卡片'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        color: Colors.blue[50],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 稀有度下拉選單區塊
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0), // 調整區塊之間的間隔距離
              child: Row(
                children: [
                  const Text('稀有度: ', style: TextStyle(color: Colors.blue)),
                  DropdownButton<String>(
                    hint: const Text('選擇稀有度'),
                    value: selectedRarity,
                    onChanged: (value) {
                      setState(() {
                        selectedRarity = value;
                      });
                    },
                    items: rarityOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // 類型下拉選單區塊
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0), // 調整區塊之間的間隔距離
              child: Row(
                children: [
                  const Text('類型: ', style: TextStyle(color: Colors.blue)),
                  DropdownButton<String>(
                    hint: const Text('選擇類型'),
                    value: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                    items: typeOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // 聖水花費下拉選單區塊
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0), // 調整區塊之間的間隔距離
              child: Row(
                children: [
                  const Text('聖水花費: ', style: TextStyle(color: Colors.blue)),
                  DropdownButton<String>(
                    hint: const Text('選擇聖水花費'),
                    value: selectedElixirCost,
                    onChanged: (value) {
                      setState(() {
                        selectedElixirCost = value;
                      });
                    },
                    items: elixirCostOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // 搜尋按鈕
            ElevatedButton(
              onPressed: _search,
              child: const Text('搜尋'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white, // 調整字體顏色
              ),
            ),
            // 清空按鈕
            ElevatedButton(
              onPressed: _clearSelections,
              child: const Text('清空'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white, // 調整字體顏色
              ),
            ),
            // 顯示搜尋結果
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text('沒有搜尋結果'))
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        var dataPlace = '${searchResults[index][2]}卡/${searchResults[index][1]}';
                        showImagePath(dataPlace);
                        return GestureDetector(
                          onTap: () {
                            List<String> updatedData = List.from(searchResults[index]);
                            updatedData.removeAt(0);

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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}