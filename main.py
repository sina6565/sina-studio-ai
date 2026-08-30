
from fastapi import FastAPI
app = FastAPI()
@app.get("/")
def root():
    return {"message": "Sina Studio AI is running!"}
