import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../services/api_service.dart';

class ImageGenerationScreen extends StatefulWidget {
  const ImageGenerationScreen({Key? key}) : super(key: key);

  @override
  State<ImageGenerationScreen> createState() => _ImageGenerationScreenState();
}

class _ImageGenerationScreenState extends State<ImageGenerationScreen> {
  late ApiService _apiService;
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _generatedImageUrl;
  String? _errorMessage;
  
  String _selectedSize = "1024x1024";
  String _selectedQuality = "standard";

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

  Future<void> _generateImage() async {
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
      final result = await _apiService.generateImage(
        prompt: _promptController.text,
        size: _selectedSize,
        quality: _selectedQuality,
      );

      if (result['success']) {
        setState(() {
          _generatedImageUrl = result['image_url'];
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
        title: Text('تولید تصویر'),
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
                hintText: 'توصیف تصویری که می‌خواهید ایجاد شود...',
                label: Text('Prompt'),
              ),
            ),
            SizedBox(height: 16),

            // Size Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اندازه تصویر',
                      style: TextStyle(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedSize,
                      isExpanded: true,
                      items: ['1024x1024', '512x512', '1024x768']
                          .map((size) => DropdownMenuItem(
                                value: size,
                                child: Text(size),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedSize = value ?? _selectedSize);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Quality Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'کیفیت',
                      style: TextStyle(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedQuality,
                      isExpanded: true,
                      items: ['standard', 'high', 'ultra']
                          .map((quality) => DropdownMenuItem(
                                value: quality,
                                child: Text(quality),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedQuality = value ?? _selectedQuality);
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
                onPressed: _isLoading ? null : _generateImage,
                icon: Icon(_isLoading ? Icons.hourglass_empty : Icons.image),
                label: Text(_isLoading ? 'در حال تولید...' : 'تولید تصویر'),
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

            if (_generatedImageUrl != null) ...[
              SizedBox(height: 24),
              Card(
                child: Column(
                  children: [
                    Image.network(
                      _generatedImageUrl!,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          color: AppTheme.surfaceColor,
                          child: Center(
                            child: Text('خطا در بارگذاری تصویر'),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Download or share functionality can be added here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('لینک: $_generatedImageUrl')),
                          );
                        },
                        child: Text('کپی لینک'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
