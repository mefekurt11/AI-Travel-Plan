import 'package:flutter/services.dart' show rootBundle;

class Env {
  /// Tek dosya: assets/prompts/prompt.txt
  static Future<String> loadPrompt() async =>
      await rootBundle.loadString('assets/prompts/prompt.txt');
}
