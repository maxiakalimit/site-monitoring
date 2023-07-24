import 'model/report_handler.dart';
import 'package:http/http.dart' as http;
import 'package:l/l.dart';

import 'model/run_arguments.dart';

class SiteMonitoring {
  final RunArguments initData;

  /// Список логгеров
  final List<ReportHandler> handlers;

  const SiteMonitoring({
    required this.initData,
    required this.handlers,
  });

  Future<void> statusProcessing() async {
    for (var url in initData.urls) {
      var uri = Uri.parse(url);
      try {
        var response = await http.get(uri);
        if (response.statusCode == 200) {
          l.i("Сервер доступен - $url");
        }
        if (response.statusCode != 200) {
          throw Exception();
        }
      } on Object catch (err, _) {
        for (var handler in handlers) {
          final mes = "Ошибка подключения - $url.\nError: $err";
          l.e(mes);
          handler.handle(mes);
        }
      }
    }
  }

  Future<void> run() async {
    l.i("Starting");
    l.i("Init data:\n${initData.toString()}");
    while (true) {
      await statusProcessing();

      await Future.delayed(Duration(seconds: initData.delay));
    }
  }
}
