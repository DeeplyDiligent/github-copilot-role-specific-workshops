from flask import Flask
from .routes import main
from .extensions import init_extensions

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'your_secret_key'  # Replace with a strong secret key
    app.register_blueprint(main)
    
    # Initialize extensions
    init_extensions(app)
    
    return app