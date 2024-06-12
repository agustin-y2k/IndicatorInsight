from fastapi import APIRouter
from utils.auth import create_user, get_access_token
from models.user import User

router = APIRouter()

@router.post("/register")
async def create_user_route(user_data: User):
    return await create_user(user_data.email, user_data.password)

@router.post("/login")
async def login_for_access_token(user_data: User):
    return await get_access_token(user_data.email, user_data.password)

