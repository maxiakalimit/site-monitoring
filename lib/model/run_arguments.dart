class RunArguments {
  /// Путь к файлу с ссылками на сайты
  final String path;
  final String telegramBotToken;
  final String telegramChatId;

  /// Задержка в секундах между опросами
  final int delay;

  /// Список url адресов
  final List<String> urls;

  RunArguments({
    required this.path,
    required this.telegramBotToken,
    required this.telegramChatId,
    required this.delay,
    required this.urls,
  });

  @override
  String toString() {
    return 'Path: $path \n'
        'TelegramBotToken: $telegramBotToken \n'
        'TelegramChatId: $telegramChatId \n'
        'Delay: $delay seconds \n'
        'Urls: $urls';
  }
}
