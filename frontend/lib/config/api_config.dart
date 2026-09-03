class ApiConfig {
  static const String apiUrl = "http://localhost:8000";
  
  // Image Generation
  static const String generateImageEndpoint = "$apiUrl/generate-image";
  
  // Video Generation
  static const String generateVideoEndpoint = "$apiUrl/generate-video";
  
  // Audio Generation
  static const String generateAudioEndpoint = "$apiUrl/generate-audio";
  
  // Text to Speech
  static const String textToSpeechEndpoint = "$apiUrl/text-to-speech";
  
  // Health Check
  static const String healthCheckEndpoint = "$apiUrl/health";
  
  // Timeouts
  static const Duration requestTimeout = Duration(seconds: 120);
  static const Duration videoTimeout = Duration(seconds: 300);
}
