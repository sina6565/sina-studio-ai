import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../services/api_service.dart';

class VideoGenerationScreen extends StatefulWidget {
  const VideoGenerationScreen({Key? key}) : super(key: key);

  @override
  State<VideoGenerationScreen> createState() => _VideoGenerationScreenState();
}

class _VideoGenerationScreenState extends State<VideoGenerationScreen> {
  late ApiService _apiService;
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _generatedVideoUrl;
  String? _videoStatus;
  String? _errorMessage;
  
  int _duration = 10;
  int _fps = 24;

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

  Future<void> _generateVideo() async {
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
      final result = await _apiService.generateVideo(
        prompt: _promptController.text,
        duration: _duration,
        fps: _fps,
      );

      if (result['success']) {
        setState(() {
          _generatedVideoUrl = result['video_url'];
          _videoStatus = result['status'];
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
        title: Text('تولید ویدئو'),
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
                hintText: 'توصیف ویدئویی که می‌خواهید ایجاد شود...',
                label: Text('Prompt'),
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
                      min: 5,
                      max: 60,
                      divisions: 11,
                      onChanged: (value) {
                        setState(() => _duration = value.toInt());
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // FPS Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سرعت فریم (FPS)',
                      style: TextStyle(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButton<int>(
                      value: _fps,
                      isExpanded: true,
                      items: [24, 30, 60]
                          .map((fps) => DropdownMenuItem(
                                value: fps,
                                child: Text('$fps FPS'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _fps = value ?? _fps);
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
                onPressed: _isLoading ? null : _generateVideo,
                icon: Icon(_isLoading ? Icons.hourglass_empty : Icons.videocam),
                label: Text(_isLoading ? 'در حال تولید...' : 'تولید ویدئو'),
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

            if (_generatedVideoUrl != null) ...[
              SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.videocam, size: 48, color: AppTheme.primaryGold),
                      SizedBox(height: 12),
                      Text(
                        'ویدئو آماده است',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'وضعیت: $_videoStatus',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('لینک: $_generatedVideoUrl')),
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
