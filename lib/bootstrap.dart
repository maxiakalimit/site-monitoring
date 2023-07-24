import 'package:args/args.dart';
import 'package:site_monitoring/model/run_arguments.dart';
import 'package:site_monitoring/utils/file_parser.dart';

Future<RunArguments> bootstrap(List<String> arguments) async {
  final parser = ArgParser();
  parser
    ..addOption('path', help: 'Path to file with url')
    ..addOption('token', help: 'Telegram bot token')
    ..addOption('chatId', help: 'Telegram chat id')
    ..addOption('delay', help: 'Delay in seconds', defaultsTo: '60');

  ArgResults argResults = parser.parse(arguments);
  final argErrors = <String>[];
  if (argResults['path'] == null) {
    argErrors.add('Path cannot be empty');
  }

  if (argResults['token'] == null) {
    argErrors.add('Telegram token cannot be empty');
  }

  if (argResults['chatId'] == null) {
    argErrors.add('Telegram chatId cannot be empty');
  }

  if (int.tryParse(argResults['delay']) == null) {
    argErrors.add('Delay must be an integer');
  }

  if (argErrors.isNotEmpty) {
    argErrors.insert(0, 'Invalid argument(s):');
    throw Exception(argErrors.join('\n'));
  }

  final urls = await FileParser(filePath: argResults['path']).parse();

  return RunArguments(
    path: argResults['path'],
    telegramBotToken: argResults['token'],
    telegramChatId: argResults['chatId'],
    delay: int.parse(argResults['delay']),
    urls: urls,
  );
}
