# email_utils.py
import os
from aiosmtplib import SMTP
from email.message import EmailMessage
from dotenv import load_dotenv

load_dotenv()

async def send_reset_password_code(email: str, reset_code: str):
    port = int(os.getenv("MAIL_PORT"))
    hostname = os.getenv("MAIL_SERVER")
    use_tls = os.getenv("MAIL_SSL") == "True"

    message = EmailMessage()
    message["From"] = os.getenv("MAIL_FROM")
    message["To"] = email
    message["Subject"] = "Password Reset Code"
    message.set_content(f"Your password reset code is: {reset_code}")

    smtp = SMTP(hostname=hostname, port=port, use_tls=use_tls)
    await smtp.connect()
    await smtp.login(os.getenv("MAIL_USERNAME"), os.getenv("MAIL_PASSWORD"))
    await smtp.send_message(message)
    await smtp.quit()
