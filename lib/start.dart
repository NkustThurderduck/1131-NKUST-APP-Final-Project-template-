import 'dart:io';

void main() {
  final directory = Directory('assets/img/皇室卡牌資訊');
  final buffer = StringBuffer();

  buffer.writeln('name: final20250112');
  buffer.writeln('description: "A new Flutter project."');
  buffer.writeln('publish_to: \'none\'');
  buffer.writeln('version: 1.0.0+1');
  buffer.writeln('environment:');
  buffer.writeln('  sdk: ^3.5.4');
  buffer.writeln('dependencies:');
  buffer.writeln('  flutter:');
  buffer.writeln('    sdk: flutter');
  buffer.writeln('  cupertino_icons: ^1.0.8');
  buffer.writeln('  excel: ^2.0.6');
  buffer.writeln('dev_dependencies:');
  buffer.writeln('  flutter_test:');
  buffer.writeln('    sdk: flutter');
  buffer.writeln('  flutter_lints: ^4.0.0');
  buffer.writeln('flutter:');
  buffer.writeln('  uses-material-design: true');
  buffer.writeln('  assets:');
  buffer.writeln('    - assets/clashroyale.xlsx');
  buffer.writeln('    - assets/img/');
  buffer.writeln('    - assets/img/皇室戰爭手機圖標.png');

  if (directory.existsSync()) {
    directory.listSync(recursive: true).forEach((file) {
      if (file is File && file.path.endsWith('.png')) {
        buffer.writeln('    - ${file.path.replaceAll('\\', '/')}');
      }
    });
  }

  final pubspecFile = File('pubspec.yaml');
  pubspecFile.writeAsStringSync(buffer.toString());
  print('pubspec.yaml file has been updated.');
}