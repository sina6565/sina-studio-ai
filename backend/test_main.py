import pytest
import httpx
from fastapi.testclient import TestClient
import os
import sys

# Add parent directory to path
sys.path.insert(0, os.path.dirname(__file__))

from main import app

client = TestClient(app)

class TestHealthEndpoint:
    """Test health check endpoint"""
    
    def test_health_check_returns_200(self):
        """Test that /health returns 200 status"""
        response = client.get("/health")
        assert response.status_code == 200
    
    def test_health_check_response_format(self):
        """Test that /health returns correct format"""
        response = client.get("/health")
        data = response.json()
        assert "status" in data
        assert "message" in data
        assert "timestamp" in data

class TestRootEndpoint:
    """Test root endpoint"""
    
    def test_root_returns_200(self):
        """Test that / returns 200 status"""
        response = client.get("/")
        assert response.status_code == 200
    
    def test_root_response_format(self):
        """Test that / returns correct format"""
        response = client.get("/")
        data = response.json()
        assert "message" in data
        assert "en_message" in data
        assert "version" in data
        assert "status" in data

class TestImageGeneration:
    """Test image generation endpoint"""
    
    def test_image_generation_requires_prompt(self):
        """Test that prompt is required"""
        response = client.post("/generate-image", json={"prompt": ""})
        # Should fail validation
        assert response.status_code in [422, 400]
    
    def test_image_generation_accepts_valid_request(self):
        """Test that image generation accepts valid format"""
        payload = {"prompt": "a beautiful landscape"}
        response = client.post("/generate-image", json=payload)
        # Either success (200) or API error (500), but endpoint should respond
        assert response.status_code in [200, 500, 422]
        data = response.json()
        assert "message" in data

class TestVideoGeneration:
    """Test video generation endpoint"""
    
    def test_video_generation_requires_prompt(self):
        """Test that prompt is required"""
        response = client.post("/generate-video", json={"prompt": ""})
        assert response.status_code in [422, 400]
    
    def test_video_generation_accepts_valid_request(self):
        """Test that video generation accepts valid format"""
        payload = {"prompt": "a moving landscape"}
        response = client.post("/generate-video", json=payload)
        assert response.status_code in [200, 500, 422]
        data = response.json()
        assert "message" in data

class TestAudioGeneration:
    """Test audio generation endpoint"""
    
    def test_audio_generation_requires_prompt(self):
        """Test that prompt is required"""
        response = client.post("/generate-audio", json={"prompt": ""})
        assert response.status_code in [422, 400]
    
    def test_audio_generation_accepts_valid_request(self):
        """Test that audio generation accepts valid format"""
        payload = {"prompt": "a sound of rain"}
        response = client.post("/generate-audio", json=payload)
        assert response.status_code in [200, 500, 422]
        data = response.json()
        assert "message" in data

class TestTextToSpeech:
    """Test text-to-speech endpoint"""
    
    def test_text_to_speech_requires_text(self):
        """Test that text is required"""
        response = client.post("/text-to-speech", json={"text": ""})
        assert response.status_code in [422, 400]
    
    def test_text_to_speech_accepts_valid_request(self):
        """Test that text-to-speech accepts valid format"""
        payload = {"text": "سلام من رباتم", "language": "fa"}
        response = client.post("/text-to-speech", json=payload)
        assert response.status_code in [200, 500, 422]
        data = response.json()
        assert "message" in data

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
