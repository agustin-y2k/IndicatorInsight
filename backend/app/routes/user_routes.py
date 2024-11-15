# user_routes.py
<<<<<<< HEAD
from fastapi import APIRouter
from utils.auth import create_user, get_access_token
from models.user import User

router = APIRouter()

=======
import random
from datetime import datetime, timedelta
from utils.auth import create_user, get_access_token, validate_password, users_collection
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from utils.email_utils import send_reset_password_code
from models.user import User
import bcrypt
import os

router = APIRouter()

class PasswordResetRequest(BaseModel):
    email: str

class CodeVerificationRequest(BaseModel):
    email: str
    code: str

class NewPasswordRequest(BaseModel):
    email: str
    new_password: str

def generate_reset_code():
    return str(random.randint(100000, 999999))

>>>>>>> develop
@router.post("/register")
async def create_user_route(user_data: User):
    return await create_user(user_data.email, user_data.password)

@router.post("/login")
async def login_for_access_token(user_data: User):
    return await get_access_token(user_data.email, user_data.password)

<<<<<<< HEAD
=======
@router.post("/request-password-reset")
async def request_password_reset(data: PasswordResetRequest):
    user = users_collection.find_one({"email": data.email})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    reset_code = generate_reset_code()
    expiration = datetime.utcnow() + timedelta(minutes=10)

    users_collection.update_one(
        {"email": data.email},
        {"$set": {"reset_code": reset_code, "reset_code_expiration": expiration}}
    )

    await send_reset_password_code(data.email, reset_code)
    return {"message": "Password reset code sent"}

@router.post("/verify-reset-code")
async def verify_reset_code(data: CodeVerificationRequest):
    user = users_collection.find_one({"email": data.email})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    if user.get("reset_code") != data.code:
        raise HTTPException(status_code=400, detail="Invalid reset code")
    
    if user.get("reset_code_expiration") < datetime.utcnow():
        raise HTTPException(status_code=400, detail="Reset code has expired")

    return {"message": "Reset code verified successfully"}

@router.post("/set-new-password")
async def set_new_password(data: NewPasswordRequest):
    user = users_collection.find_one({"email": data.email})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    if not validate_password(data.new_password):
        raise HTTPException(status_code=400, detail="Password does not meet requirements")

    hashed_password = bcrypt.hashpw(data.new_password.encode('utf-8'), bcrypt.gensalt())
    users_collection.update_one(
        {"email": data.email},
        {"$set": {"password": hashed_password.decode('utf-8')}, "$unset": {"reset_code": "", "reset_code_expiration": ""}}
    )
    return {"message": "Password reset successful"}
>>>>>>> develop
