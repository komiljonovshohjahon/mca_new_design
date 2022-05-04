import 'package:flutter/services.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:mca_new_design/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:timezone/data/latest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(Constants.hiveBoxName);

  initializeTimeZones();

  Logger.init(true,
      isShowFile: false, isShowTime: false, isShowNavigation: false);

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const McaApp());
}

// class FileOutput extends LogOutput {
//   FileOutput();
//
//   File file;
//
//   @override
//   void init() {
//     super.init();
//     file = new File(filePath);
//   }
//
//   @override
//   void output(OutputEvent event) async {
//     if (file != null) {
//       for (var line in event.lines) {
//         await file.writeAsString("${line.toString()}\n",
//             mode: FileMode.writeOnlyAppend);
//       }
//     } else {
//       for (var line in event.lines) {
//         print(line);
//       }
//     }
//   }
// }
