import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'default_secret_key'
    QR_CODE_DIR = "app/static/qr_codes"
    DEBUG = True