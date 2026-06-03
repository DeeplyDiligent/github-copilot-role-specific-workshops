from flask import Flask, request, send_file
import qrcode
import os
from PIL import Image
import re

from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True, port=80)