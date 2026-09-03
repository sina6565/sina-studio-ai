import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../services/api_service.dart';

class AudioGenerationScreen extends StatefulWidget {
  const AudioGenerationScreen({Key? key}) : super(key: key);

  @override
  State<AudioGenerationScreen> createState() => _AudioGenerationScreenState();
}

class _AudioGenerationScreenState extends State<AudioGenerationScreen> {
  late ApiService _apiService;
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _generatedAudioUrl;
  String? _errorMessage;
  
  String _selectedVoice = "neutral";
  int _duration = 30;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _generateAudio() async {
    if (_promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لطفاً prompt خود را وارد کنید')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _apiService.generateAudio(
        prompt: _promptController.text,
        voice: _selectedVoice,
        duration: _duration,
      );

      if (result['success']) {
        setState(() {
          _generatedAudioUrl = result['audio_url'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطا: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تولید صدا'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Section
            TextField(
              controller: _promptController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'توصیف صوتی که می‌خواهید ایجاد شود...',
                label: Text('Prompt'),
              ),
            ),
            SizedBox(height: 16),

            // Voice Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نوع صدا',
                      style: TextStyle(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedVoice,
                      isExpanded: true,
                      items: ['neutral', 'male', 'female', 'deep']
                          .map((voice) => DropdownMenuItem(
                                value: voice,
                                child: Text(voice),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedVoice = value ?? _selectedVoice);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Duration Slider
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'مدت زمان: $_duration ثانیه',
                          style: TextStyle(
                            color: AppTheme.primaryGold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _duration.toDouble(),
                      min: 10,
                      max: 120,
                      divisions: 11,
                      onChanged: (value) {
                        setState(() => _duration = value.toInt());
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Generate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generateAudio,
                icon: Icon(_isLoading ? Icons.hourglass_empty : Icons.audio_file),
                label: Text(_isLoading ? 'در حال تولید...' : 'تولید صدا'),
              ),
            ),

            if (_errorMessage != null) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.errorColor),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: AppTheme.errorColor),
                ),
              ),
            ],

            if (_generatedAudioUrl != null) ...[
              SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.audio_file, size: 48, color: AppTheme.primaryGold),
                      SizedBox(height: 12),
                      Text(
                        'صدا آماده است',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('لینک: $_generatedAudioUrl')),
                          );
                        },
                        child: Text('کپی لینک'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
