import 'package:site_monitoring/bootstrap.dart';
import 'package:site_monitoring/handlers/telegram_handler.dart';
import 'package:site_monitoring/model/report_handler.dart';
import 'package:site_monitoring/site_monitoring.dart';
import 'package:l/l.dart';

Future<void> main(List<String> arguments) async {
  final initData = await bootstrap(arguments);

  final List<ReportHandler> handlers = [
    TelegramHandler(
      botToken: initData.telegramBotToken,
      chatId: initData.telegramChatId,
    )
  ];

  final app = SiteMonitoring(
    initData: initData,
    handlers: handlers,
  );

  try {
    l.capture(
      () async => await app.run(),
      const LogOptions(
        handlePrint: true,
        printColors: true,
        outputInRelease: false,
        messageFormatting: _messageFormatting,
      ),
    );
  } on Object catch (e, trace) {
    l.e(e, trace);
  }
}

Object _messageFormatting(Object message, LogLevel logLevel, DateTime now) =>
    '$now $message';
