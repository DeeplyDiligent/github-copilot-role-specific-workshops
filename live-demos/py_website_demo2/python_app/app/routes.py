from flask import Blueprint, request, send_file, render_template
import qrcode
import os
from PIL import Image
import re

main = Blueprint('main', __name__)

# Ensure the directory for storing QR codes exists
QR_CODE_DIR = "app/static/qr_codes"
os.makedirs(QR_CODE_DIR, exist_ok=True)

@main.route('/')
def home():
    return render_template('home.html')

@main.route('/generate', methods=['POST'])
def generate_qr():
    data = request.form.get('data')
    if not data:
        return "<p>Error: No data provided. Please provide data in the 'data' form field.</p>", 400

    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(data)
    qr.make(fit=True)

    img = qr.make_image(fill_color="black", back_color="white")

    # Sanitize the file name
    sanitized_data = re.sub(r'[^a-zA-Z0-9_-]', '_', data)
    file_name = f"{sanitized_data}.png"
    file_path = os.path.join(QR_CODE_DIR, file_name)
    img.save(file_path)

    return render_template('generate.html', file_name=file_name, data=data)