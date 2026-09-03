# Sina Studio AI

**سینا استودیو - پلتفرم هوشمند برای ایجاد بازی‌ها و تولید محتوای تصویری**

Sina Studio AI is an AI-powered platform that enables creators to generate images, videos, and audio content using advanced AI models. Built with FastAPI backend and Flutter frontend.

## Features

### 🎨 Image Generation
- Generate high-quality images from text descriptions
- Multiple size options (512x512, 1024x1024, 1024x768)
- Quality settings (standard, high, ultra)
- Powered by Agnes AI

### 🎬 Video Generation
- Create engaging videos from text prompts
- Customizable duration and frame rates
- Async video processing with status tracking
- Suitable for game scenes and animations

### 🔊 Audio Generation
- Generate realistic audio from text prompts
- Multiple voice options
- Customizable duration
- Ideal for game backgrounds and effects

### 🗣️ Text-to-Speech
- Convert text to speech with natural voice
- Persian (Farsi) language support
- Multiple voice styles
- Quick audio generation for narration

## Tech Stack

### Backend
- **Framework**: FastAPI (Python)
- **Runtime**: Uvicorn
- **API**: RESTful with async support
- **AI Provider**: Agnes AI
- **Container**: Docker & Docker Compose

### Frontend
- **Framework**: Flutter 3.0+
- **Language**: Dart
- **Design**: Material 3
- **Localization**: Persian/Farsi support

## Project Structure

```
sina-studio-ai/
├── backend/
│   ├── main.py                 # FastAPI application
│   ├── config.py               # Configuration management
│   ├── utils.py                # Utility functions
│   ├── requirements.txt         # Python dependencies
│   ├── Dockerfile              # Container configuration
│   ├── test_main.py            # Unit tests
│   └── .env.example            # Environment template
├── frontend/
│   ├── lib/
│   │   ├── main.dart           # Flutter entry point
│   │   ├── config/
│   │   │   ├── theme.dart      # App theming
│   │   │   └── api_config.dart # API configuration
│   │   ├── screens/
│   │   │   ├── home_screen.dart
│   │   │   ├── image_generation_screen.dart
│   │   │   ├── video_generation_screen.dart
│   │   │   └── audio_generation_screen.dart
│   │   └── services/
│   │       └── api_service.dart # HTTP client
│   ├── pubspec.yaml            # Flutter dependencies
│   └── android/, ios/, web/    # Platform-specific code
├── docker-compose.yml          # Multi-container setup
└── README.md                   # This file
```

## Installation & Setup

### Prerequisites
- Python 3.10+
- Flutter 3.0+
- Docker & Docker Compose (optional)
- Agnes AI API Key

### Backend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/sina6565/sina-studio-ai.git
   cd sina-studio-ai
   ```

2. **Create Python virtual environment**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env and add your Agnes AI API key
   export AGNES_API_KEY=your_api_key_here
   ```

5. **Run the API server**
   ```bash
   python main.py
   # OR
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

   The API will be available at `http://localhost:8000`

### Frontend Setup

1. **Navigate to frontend directory**
   ```bash
   cd frontend
   ```

2. **Get Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Update API configuration** (if needed)
   Edit `lib/config/api_config.dart` to point to your backend:
   ```dart
   static const String apiUrl = "http://your-backend-url:8000";
   ```

4. **Run the application**
   ```bash
   flutter run
   # For web:
   flutter run -d chrome
   # For iOS:
   flutter run -d ios
   # For Android:
   flutter run -d android
   ```

### Docker Deployment

1. **Build and run with Docker Compose**
   ```bash
   docker-compose up -d
   ```

2. **Check service health**
   ```bash
   curl http://localhost:8000/health
   ```

## API Documentation

### Base URL
```
http://localhost:8000
```

### Endpoints

#### 1. Health Check
```
GET /health
```
**Response:**
```json
{
  "status": "healthy",
  "message": "Server is running smoothly",
  "api_configured": true,
  "timestamp": "2026-09-03T23:14:46.123456"
}
```

#### 2. Generate Image
```
POST /generate-image
Content-Type: application/json

{
  "prompt": "a beautiful sunset over mountains",
  "size": "1024x1024",
  "quality": "high"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Image generated successfully",
  "image_url": "https://..."
}
```

#### 3. Generate Video
```
POST /generate-video
Content-Type: application/json

{
  "prompt": "a person walking in a forest",
  "duration": 10,
  "fps": 24
}
```

**Response:**
```json
{
  "success": true,
  "message": "Video generation started",
  "video_url": "https://...",
  "status": "processing"
}
```

#### 4. Generate Audio
```
POST /generate-audio
Content-Type: application/json

{
  "prompt": "sound of rain falling",
  "voice": "neutral",
  "duration": 30
}
```

**Response:**
```json
{
  "success": true,
  "message": "Audio generated successfully",
  "audio_url": "https://..."
}
```

#### 5. Text-to-Speech
```
POST /text-to-speech
Content-Type: application/json

{
  "text": "سلام، خوش‌آمدید",
  "voice": "neutral",
  "language": "fa"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Speech generated successfully",
  "audio_url": "https://..."
}
```

## Testing

### Backend Tests
```bash
cd backend
pytest test_main.py -v
```

### Run with coverage
```bash
pytest test_main.py --cov=. --cov-report=html
```

## Environment Variables

Create a `.env` file in the backend directory:

```env
# Agnes AI Configuration
AGNES_API_KEY=your_api_key_here

# Server Configuration
HOST=0.0.0.0
PORT=8000
DEBUG=False

# CORS Configuration
CORS_ORIGINS=*

# API Configuration
API_TITLE=Sina Studio AI
API_VERSION=1.0.0
```

## Configuration

### Backend Configuration (`config.py`)
- API Models: agnes-image-2.1-flash, agnes-video-2.0, agnes-audio-2.0
- Timeout Settings: 120s (images/audio), 300s (video)
- CORS: Enabled for all origins

### Frontend Theme (`lib/config/theme.dart`)
- Primary Color: Gold (#D4AF37)
- Background: Black (#1a1a1a)
- Material Design 3 compliant
- Farsi font support (Vazirmatn)

## Development

### Backend Development
- Code follows PEP 8 style guide
- Type hints for better code clarity
- Async/await for non-blocking I/O
- Comprehensive error handling

### Frontend Development
- Follows Flutter best practices
- Material Design principles
- Responsive UI for all screen sizes
- RTL support for Persian language

## Troubleshooting

### Backend won't start
- Check if port 8000 is available
- Verify AGNES_API_KEY is set
- Check Python version (3.10+ required)

### Flutter app can't connect to backend
- Ensure backend is running
- Check API URL in `lib/config/api_config.dart`
- For Android emulator: use `10.0.2.2:8000` instead of `localhost:8000`

### API requests timeout
- Increase timeout values in config
- Check Agnes AI service availability
- Verify network connection

## License

This project is licensed under the MIT License - see LICENSE file for details.

## Support & Contact

For issues, questions, or suggestions:
- GitHub Issues: https://github.com/sina6565/sina-studio-ai/issues

---

**Made with ❤️ by Sina Studio Team**

سینا استودیو - تکنولوژی برای خلاقیت
