# Sina Studio AI

A comprehensive platform for creating games and generating content using AI.

سینا استودیو - پلتفرمی جامع برای ساخت بازی و تولید محتوا با هوش مصنوعی

## Features

### Backend (FastAPI)
- Image generation with Agnes AI
- Video generation with Agnes AI
- Audio generation with Agnes AI
- Health check endpoints
- RESTful API

### Frontend (Flutter)
- Material Design 3 UI
- Golden and Black branding colors
- Persian font support (Vazirmatn)
- Image, video, and audio generation screens
- Real-time API integration

## Project Structure

```
sina-studio-ai/
├── backend/          # FastAPI server
├── frontend/         # Flutter application
├── .env.example      # Environment variables template
└── README.md         # This file
```

## Getting Started

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Create a `.env` file:
   ```bash
   cp .env.example .env
   ```

5. Add your Agnes API key to the `.env` file:
   ```
   AGNES_API_KEY=your_api_key_here
   ```

6. Run the server:
   ```bash
   uvicorn main:app --reload
   ```

The API will be available at `http://localhost:8000`

### Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Update the API URL in `lib/config/api_config.dart` if needed

4. Run the app:
   ```bash
   flutter run
   ```

## API Endpoints

- `GET /` - Welcome message
- `GET /health` - Health check
- `POST /generate-image` - Generate image
- `POST /generate-video` - Generate video
- `POST /generate-audio` - Generate audio

## Technologies Used

- **Backend**: Python, FastAPI, httpx, python-dotenv
- **Frontend**: Flutter, Dart
- **AI**: Agnes AI Models
- **Database**: Optional (planned for future)

## License

MIT License
