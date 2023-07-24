import 'dart:io';

class FileParser {
  final String filePath;

  FileParser({
    required this.filePath,
  });

  Future<List<String>> parse() async {
    File file = File(filePath);

    try {
      var fileContent = await file.readAsLines();

      return fileContent;
    } on Object catch (_) {
      rethrow;
    }
  }
}
