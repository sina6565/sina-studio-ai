import base64
from io import BytesIO
from PIL import Image
import httpx
from typing import Optional

async def download_and_encode_image(url: str) -> Optional[str]:
    """Download image from URL and encode to base64"""
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(url, timeout=30.0)
            if response.status_code == 200:
                return base64.b64encode(response.content).decode()
    except Exception as e:
        print(f"Error downloading image: {e}")
    return None

async def download_and_encode_audio(url: str) -> Optional[str]:
    """Download audio from URL and encode to base64"""
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(url, timeout=30.0)
            if response.status_code == 200:
                return base64.b64encode(response.content).decode()
    except Exception as e:
        print(f"Error downloading audio: {e}")
    return None

async def download_and_encode_video(url: str) -> Optional[str]:
    """Download video from URL and encode to base64"""
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(url, timeout=60.0)
            if response.status_code == 200:
                return base64.b64encode(response.content).decode()
    except Exception as e:
        print(f"Error downloading video: {e}")
    return None

def resize_image(image_data: bytes, size: tuple = (512, 512)) -> bytes:
    """Resize image to specified size"""
    try:
        img = Image.open(BytesIO(image_data))
        img = img.resize(size, Image.Resampling.LANCZOS)
        output = BytesIO()
        img.save(output, format="PNG")
        return output.getvalue()
    except Exception as e:
        print(f"Error resizing image: {e}")
        return image_data
