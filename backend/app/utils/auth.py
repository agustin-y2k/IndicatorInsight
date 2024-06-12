# auth.py
import os
import jwt
from fastapi import HTTPException, status, Depends
from fastapi.security import OAuth2PasswordBearer
from datetime import datetime, timedelta, timezone
from pymongo import MongoClient
import bcrypt
import re
from dotenv import load_dotenv

load_dotenv()

# Configuración de seguridad JWT
SECRET_KEY = os.getenv("SECRET_KEY", "fallbacksecretkey")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_DAYS = 30

client = MongoClient('mongodb', 27017)
db = client['indicator_insight']
# Comprobación y creación automática de la colección 'users'
if 'users' not in db.list_collection_names():
    db.create_collection('users')

# Asignación de la colección
users_collection = db['users']

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Define una función para validar la fortaleza de la contraseña
def validate_password(password: str) -> bool:
    if len(password) < 8:
        return False
    if not re.search(r"\d", password):
        return False
    if not re.search(r"[a-z]", password) or not re.search(r"[A-Z]", password):
        return False
    if not re.search(r"[!@#$%^&*()-_=+{};:,<.>]", password):
        return False
    return True

def validate_email(email: str) -> bool:
    email_regex = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(email_regex, email) is not None

def create_access_token(data: dict, expires_delta: timedelta):
    to_encode = data.copy()
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def decode_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token has expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")

class TokenData:
    def __init__(self, email: str = None, role: str = None):
        self.email = email
        self.role = role

async def get_current_user(token: str = Depends(oauth2_scheme)):
    payload = decode_token(token)
    email = payload.get("sub")
    if email is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return TokenData(email=email, role=payload.get("role"))

async def get_current_active_user(current_user: TokenData = Depends(get_current_user)):
    user = users_collection.find_one({"email": current_user.email})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    if not user["is_active"]:
        raise HTTPException(status_code=400, detail="Inactive user")
    return user

async def get_current_active_admin(current_user: TokenData = Depends(get_current_user)):
    user = users_collection.find_one({"email": current_user.email})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    if not user["is_active"]:
        raise HTTPException(status_code=400, detail="Inactive user")
    if user["role"] != "admin":
        raise HTTPException(status_code=400, detail="User is not an admin")
    return user

async def create_user(email: str, password: str):
    existing_user = users_collection.find_one({"email": email})
    if existing_user:
        raise HTTPException(status_code=401, detail="User already exists")

    if not validate_email(email):
        raise HTTPException(status_code=400, detail="Invalid email format")

    if not validate_password(password):
        raise HTTPException(status_code=400, detail="Password must be at least 8 characters long and contain at least one digit, one uppercase letter, one lowercase letter, and one special character")

    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    user = {
        "email": email,
        "password": hashed_password.decode('utf-8'),
        "role": "user",
        "is_active": True
    }
    users_collection.insert_one(user)
    access_token_expires = timedelta(days=ACCESS_TOKEN_EXPIRE_DAYS)
    access_token = create_access_token(
        data={"sub": user["email"], "role": user["role"]}, expires_delta=access_token_expires)
    
    return {"message": "User created successfully", "access_token": access_token, "token_type": "bearer"}

async def authenticate_user(email: str, password: str):
    user = users_collection.find_one({"email": email})
    if not user or not bcrypt.checkpw(password.encode('utf-8'), user['password'].encode('utf-8')):
        raise HTTPException(status_code=401, detail="Incorrect email or password")
    return user

async def get_access_token(email: str, password: str):
    user = await authenticate_user(email, password)
    access_token_expires = timedelta(days=ACCESS_TOKEN_EXPIRE_DAYS)
    access_token = create_access_token(
        data={"sub": user["email"], "role": user["role"]}, expires_delta=access_token_expires)
    return {"access_token": access_token, "token_type": "bearer"}
