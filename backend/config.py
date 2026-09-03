import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    """Application settings and configuration"""
    
    # API Configuration
    API_TITLE = "Sina Studio AI"
    API_VERSION = "1.0.0"
    API_DESCRIPTION = "AI-powered platform for creating games and generating content"
    
    # Agnes AI Configuration
    AGNES_API_KEY = os.getenv("AGNES_API_KEY")
    AGNES_API_URL = "https://api.agnesai.co/v1"
    AGNES_IMAGE_MODEL = "agnes-image-2.1-flash"
    AGNES_VIDEO_MODEL = "agnes-video-2.0"
    AGNES_AUDIO_MODEL = "agnes-audio-2.0"
    
    # Server Configuration
    HOST = os.getenv("HOST", "0.0.0.0")
    PORT = int(os.getenv("PORT", 8000))
    DEBUG = os.getenv("DEBUG", "False").lower() == "true"
    
    # CORS Configuration
    CORS_ORIGINS = os.getenv("CORS_ORIGINS", "*").split(",")
    
    # Timeout Configuration (in seconds)
    IMAGE_TIMEOUT = 120
    VIDEO_TIMEOUT = 300
    AUDIO_TIMEOUT = 120
    
    @classmethod
    def validate(cls):
        """Validate critical configuration"""
        if not cls.AGNES_API_KEY:
            raise ValueError("AGNES_API_KEY environment variable is not set")
        return True

settings = Settings()
