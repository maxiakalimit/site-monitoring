import 'dart:convert';

import 'package:site_monitoring/model/report_handler.dart';
import 'package:l/l.dart';
import 'package:http/http.dart' as http;

class TelegramHandler implements ReportHandler {
  final String botToken;
  final String chatId;

  TelegramHandler({
    required this.botToken,
    required this.chatId,
  });

  @override
  Future<bool> handle(String message) async {
    final url = "https://api.telegram.org/bot$botToken/sendMessage";
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final data = <String, dynamic>{
      'chat_id': chatId,
      'text': message,
    };

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      if (res.statusCode != 200) {
        throw Exception("Status code: ${res.statusCode}");
      }
    } on Object catch (err, trace) {
      l.e('Telegram send message with error: $err', trace);
    }

    return true;
  }
}
