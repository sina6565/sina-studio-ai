import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiService _apiService;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    final isConnected = await _apiService.healthCheck();
    setState(() {
      _isConnected = isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سینا استودیو'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Status Indicator
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isConnected
                              ? AppTheme.successColor
                              : AppTheme.errorColor,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        _isConnected
                            ? 'سرور متصل است'
                            : 'سرور قطع است',
                        style: TextStyle(
                          color: _isConnected
                              ? AppTheme.successColor
                              : AppTheme.errorColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              
              // Main Title
              Text(
                'خوش‌آمدید به سینا استودیو',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 16),
              
              Text(
                'با هوش مصنوعی تصویر، ویدئو و صدا ایجاد کنید',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 48),
              
              // Feature Buttons
              _buildFeatureButton(
                context,
                icon: Icons.image,
                title: 'تولید تصویر',
                description: 'تصویرهای شگفت‌انگیز با AI',
                onTap: () => Navigator.pushNamed(context, '/image'),
              ),
              SizedBox(height: 16),
              
              _buildFeatureButton(
                context,
                icon: Icons.videocam,
                title: 'تولید ویدئو',
                description: 'ویدئوهای متحرک با AI',
                onTap: () => Navigator.pushNamed(context, '/video'),
              ),
              SizedBox(height: 16),
              
              _buildFeatureButton(
                context,
                icon: Icons.audio_file,
                title: 'تولید صدا',
                description: 'صداهای واقعی با AI',
                onTap: () => Navigator.pushNamed(context, '/audio'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.primaryGold, size: 48),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: AppTheme.primaryGold),
            ],
          ),
        ),
      ),
    );
  }
}
