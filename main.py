from fastapi import FastAPI
import os

app = FastAPI(title="Sina Studio AI", version="1.0.0")

PORT = int(os.getenv("PORT", 8000))

@app.get("/")
def root():
    return {"message": f"Sina Studio AI is running on port {PORT}!"}

@app.get("/health")
def health():
    return {"status": "ok", "message": "Service is healthy"}
