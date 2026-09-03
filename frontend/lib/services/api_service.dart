import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  
  factory ApiService() {
    return _instance;
  }
  
  ApiService._internal();
  
  Future<Map<String, dynamic>> generateImage({
    required String prompt,
    String size = "1024x1024",
    String quality = "standard",
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.generateImageEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt,
          'size': size,
          'quality': quality,
        }),
      ).timeout(ApiConfig.requestTimeout);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
  
  Future<Map<String, dynamic>> generateVideo({
    required String prompt,
    int duration = 10,
    int fps = 24,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.generateVideoEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt,
          'duration': duration,
          'fps': fps,
        }),
      ).timeout(ApiConfig.videoTimeout);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
  
  Future<Map<String, dynamic>> generateAudio({
    required String prompt,
    String voice = "neutral",
    int duration = 30,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.generateAudioEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt,
          'voice': voice,
          'duration': duration,
        }),
      ).timeout(ApiConfig.requestTimeout);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
  
  Future<Map<String, dynamic>> textToSpeech({
    required String text,
    String voice = "neutral",
    String language = "fa",
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.textToSpeechEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': text,
          'voice': voice,
          'language': language,
        }),
      ).timeout(ApiConfig.requestTimeout);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
  
  Future<bool> healthCheck() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.healthCheckEndpoint),
      ).timeout(Duration(seconds: 5));
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
