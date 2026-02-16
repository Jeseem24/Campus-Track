import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // 1. Load API Key
  final envFile = File('.env');
  final lines = await envFile.readAsLines();
  String? apiKey;
  for (var line in lines) {
    if (line.startsWith('GEMINI_API_KEY=')) {
      apiKey = line.split('=')[1].trim();
      break;
    }
  }

  if (apiKey == null) {
    print('NO_KEY');
    return;
  }

  print('Using Key: ${apiKey.substring(0, 5)}...');

  // 2. List Models
  final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey');

  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final models = data['models'] as List<dynamic>;
      print('✅ AVAILABLE MODELS:');
      final logFile = File('tool/models_output.txt');
      final sink = logFile.openWrite();
      for (var m in models) {
        final name = m['name'];
        print(' - $name');
        sink.writeln(name);
      }
      await sink.close();
    } else {
      print('❌ ERROR: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  } catch (e) {
    print('❌ EXCEPTION: $e');
  }
}
