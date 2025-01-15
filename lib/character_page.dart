import 'package:flutter/material.dart';

class character_page extends StatelessWidget {
  final List<String> Data;
  final List<String> title;

  // 將 Data 類型改為 List<String>，以便確保所有元素都是字符串
  character_page({super.key, required List<dynamic> Data})
      : Data = Data.map((item) => item.toString()).toList(),
  // 將 Data 轉換為 List<String>
        title = const [
          '卡牌',
          '稀有度',
          '類型',
          '聖水花費',
          '技能聖水花費',
          '生命值',
          '護盾生命值',
          '傷害',
          '對皇家塔傷害',
          '登場傷害',
          '死亡傷害',
          '攻速(秒)',
          '射程',
          '範圍',
          '數量',
          '摧毀產兵數量',
          '出兵速度(秒)',
          '移動速度',
          '目標',
          '持續時間',
          '暈眩時間',
          '冰凍時間',
          '減速時間',
          '治療量',
          '複製等級'
        ];

  @override
  Widget build(BuildContext context) {
    // 過濾掉空的 Data 項目及其對應的 title
    List<String> filteredData = [];
    List<String> filteredTitle = [];
    for (int i = 0; i < Data.length; i++) {
      if (Data[i].trim().isNotEmpty) {
        filteredData.add(Data[i]);
        filteredTitle.add(title[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Data[0]),
        backgroundColor: Colors.blue, // 設置AppBar為藍色
      ),
      body: Column(
        children: [
          Container(
            width: 400,
            height: 400,
            margin: const EdgeInsets.only(top: 20, bottom: 20), // 設置上下20px的距離
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2), // 設置邊框
            ),
            child: Center(
              child: SizedBox(
                width: 350,
                height: 350,
                child: Image.asset(
                  'assets/img/皇室卡牌資訊/${Data[1]}卡/${Data[0]}.png',
                  fit: BoxFit.cover, // 確保圖片覆蓋整個空間
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50], // 藍色背景
                      borderRadius: BorderRadius.circular(12.0), // 圓角邊框
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2), // 藍色陰影
                          blurRadius: 4,
                          offset: const Offset(0, 4), // 陰影偏移
                        ),
                      ],
                    ),
                    child: Text(
                      '${filteredTitle[index]}：${filteredData[index]}',
                      style: TextStyle(
                        color: Colors.blue[800], // 設置文字顏色為深藍
                        fontWeight: FontWeight.bold, // 加粗字體
                        fontSize: 16.0, // 字體大小
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}