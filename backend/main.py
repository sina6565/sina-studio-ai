from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import httpx
import os
from typing import Optional
import datetime

# Initialize FastAPI app
app = FastAPI(
    title="Sina Studio AI",
    description="AI-powered platform for creating games and generating content",
    version="1.0.0"
)

# Add CORS middleware for frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Environment variables
AGNES_API_KEY = os.getenv("AGNES_API_KEY")
AGNES_API_URL = "https://api.agnesai.co/v1"

# Request models
class GenerateImageRequest(BaseModel):
    prompt: str
    size: str = "1024x1024"
    quality: str = "standard"

class GenerateVideoRequest(BaseModel):
    prompt: str
    duration: int = 10
    fps: int = 24

class GenerateAudioRequest(BaseModel):
    prompt: str
    voice: str = "neutral"
    duration: int = 30

class TextToSpeechRequest(BaseModel):
    text: str
    voice: str = "neutral"
    language: str = "fa"

# Response models
class ImageResponse(BaseModel):
    success: bool
    message: str
    image_url: Optional[str] = None

class VideoResponse(BaseModel):
    success: bool
    message: str
    video_url: Optional[str] = None
    status: Optional[str] = None

class AudioResponse(BaseModel):
    success: bool
    message: str
    audio_url: Optional[str] = None

# Routes
@app.get("/")
async def root():
    """Welcome endpoint - سلام و خوش‌آمد"""
    return {
        "message": "سلام! خوش‌آمدید به سینا استودیو",
        "en_message": "Welcome to Sina Studio AI",
        "version": "1.0.0",
        "status": "operational"
    }

@app.get("/health")
async def health_check():
    """Health check endpoint - بررسی سلامت سرور"""
    if not AGNES_API_KEY:
        return {
            "status": "unhealthy",
            "message": "AGNES_API_KEY is not configured",
            "timestamp": datetime.datetime.now().isoformat()
        }
    
    return {
        "status": "healthy",
        "message": "Server is running smoothly",
        "api_configured": True,
        "timestamp": datetime.datetime.now().isoformat()
    }

@app.post("/generate-image", response_model=ImageResponse)
async def generate_image(request: GenerateImageRequest):
    """Generate image using Agnes AI - تولید تصویر با هوش مصنوعی"""
    
    if not AGNES_API_KEY:
        raise HTTPException(
            status_code=500,
            detail="AGNES_API_KEY is not configured"
        )
    
    if not request.prompt:
        raise HTTPException(
            status_code=400,
            detail="Prompt is required"
        )
    
    try:
        async with httpx.AsyncClient(timeout=120.0) as client:
            headers = {
                "Authorization": f"Bearer {AGNES_API_KEY}",
                "Content-Type": "application/json"
            }
            
            payload = {
                "model": "agnes-image-2.1-flash",
                "prompt": request.prompt,
                "size": request.size,
                "quality": request.quality,
                "n": 1
            }
            
            response = await client.post(
                f"{AGNES_API_URL}/images/generations",
                json=payload,
                headers=headers
            )
            
            if response.status_code != 200:
                return ImageResponse(
                    success=False,
                    message=f"Agnes AI error: {response.text}"
                )
            
            data = response.json()
            image_url = data.get("data", [{}])[0].get("url")
            
            if image_url:
                return ImageResponse(
                    success=True,
                    message="Image generated successfully",
                    image_url=image_url
                )
            
            return ImageResponse(
                success=False,
                message="No image URL in response"
            )
            
    except httpx.TimeoutException:
        raise HTTPException(
            status_code=504,
            detail="Agnes AI service timeout"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error generating image: {str(e)}"
        )

@app.post("/generate-video", response_model=VideoResponse)
async def generate_video(request: GenerateVideoRequest):
    """Generate video using Agnes AI - تولید ویدئو با هوش مصنوعی"""
    
    if not AGNES_API_KEY:
        raise HTTPException(
            status_code=500,
            detail="AGNES_API_KEY is not configured"
        )
    
    if not request.prompt:
        raise HTTPException(
            status_code=400,
            detail="Prompt is required"
        )
    
    try:
        async with httpx.AsyncClient(timeout=300.0) as client:
            headers = {
                "Authorization": f"Bearer {AGNES_API_KEY}",
                "Content-Type": "application/json"
            }
            
            payload = {
                "model": "agnes-video-2.0",
                "prompt": request.prompt,
                "duration": request.duration,
                "fps": request.fps
            }
            
            response = await client.post(
                f"{AGNES_API_URL}/videos/generations",
                json=payload,
                headers=headers
            )
            
            if response.status_code not in [200, 202]:
                return VideoResponse(
                    success=False,
                    message=f"Agnes AI error: {response.text}"
                )
            
            data = response.json()
            video_url = data.get("data", {}).get("url")
            status = data.get("data", {}).get("status", "processing")
            
            return VideoResponse(
                success=True,
                message="Video generation started",
                video_url=video_url,
                status=status
            )
            
    except httpx.TimeoutException:
        raise HTTPException(
            status_code=504,
            detail="Agnes AI service timeout"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error generating video: {str(e)}"
        )

@app.post("/generate-audio", response_model=AudioResponse)
async def generate_audio(request: GenerateAudioRequest):
    """Generate audio using Agnes AI - تولید صدا با هوش مصنوعی"""
    
    if not AGNES_API_KEY:
        raise HTTPException(
            status_code=500,
            detail="AGNES_API_KEY is not configured"
        )
    
    if not request.prompt:
        raise HTTPException(
            status_code=400,
            detail="Prompt is required"
        )
    
    try:
        async with httpx.AsyncClient(timeout=120.0) as client:
            headers = {
                "Authorization": f"Bearer {AGNES_API_KEY}",
                "Content-Type": "application/json"
            }
            
            payload = {
                "model": "agnes-audio-2.0",
                "prompt": request.prompt,
                "voice": request.voice,
                "duration": request.duration
            }
            
            response = await client.post(
                f"{AGNES_API_URL}/audio/generations",
                json=payload,
                headers=headers
            )
            
            if response.status_code != 200:
                return AudioResponse(
                    success=False,
                    message=f"Agnes AI error: {response.text}"
                )
            
            data = response.json()
            audio_url = data.get("data", {}).get("url")
            
            if audio_url:
                return AudioResponse(
                    success=True,
                    message="Audio generated successfully",
                    audio_url=audio_url
                )
            
            return AudioResponse(
                success=False,
                message="No audio URL in response"
            )
            
    except httpx.TimeoutException:
        raise HTTPException(
            status_code=504,
            detail="Agnes AI service timeout"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error generating audio: {str(e)}"
        )

@app.post("/text-to-speech", response_model=AudioResponse)
async def text_to_speech(request: TextToSpeechRequest):
    """Convert text to speech - تبدیل متن به صدا"""
    
    if not AGNES_API_KEY:
        raise HTTPException(
            status_code=500,
            detail="AGNES_API_KEY is not configured"
        )
    
    if not request.text:
        raise HTTPException(
            status_code=400,
            detail="Text is required"
        )
    
    try:
        async with httpx.AsyncClient(timeout=120.0) as client:
            headers = {
                "Authorization": f"Bearer {AGNES_API_KEY}",
                "Content-Type": "application/json"
            }
            
            payload = {
                "model": "agnes-audio-2.0",
                "text": request.text,
                "voice": request.voice,
                "language": request.language
            }
            
            response = await client.post(
                f"{AGNES_API_URL}/audio/speech",
                json=payload,
                headers=headers
            )
            
            if response.status_code != 200:
                return AudioResponse(
                    success=False,
                    message=f"Agnes AI error: {response.text}"
                )
            
            data = response.json()
            audio_url = data.get("data", {}).get("url")
            
            if audio_url:
                return AudioResponse(
                    success=True,
                    message="Speech generated successfully",
                    audio_url=audio_url
                )
            
            return AudioResponse(
                success=False,
                message="No audio URL in response"
            )
            
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error converting text to speech: {str(e)}"
        )

# Error handlers
@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "success": False,
            "message": exc.detail,
            "status_code": exc.status_code
        }
    )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
