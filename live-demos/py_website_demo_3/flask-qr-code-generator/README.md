# Flask QR Code Generator

This project is a simple web application built using Flask that allows users to generate QR codes from text input. It consists of two main pages: one for user input and another for displaying the generated QR code.

## Updated Project Structure

```
flask-qr-code-generator
├── app
│   ├── __init__.py
│   ├── routes.py
│   ├── extensions.py
│   ├── models
│   │   └── __init__.py
│   ├── services
│   │   └── qr_service.py
│   ├── static
│   │   └── styles.css
│   ├── templates
│   │   ├── input.html
│   │   └── display.html
│   └── utils
│       └── __init__.py
├── requirements.txt
├── run.py
└── README.md
```

## Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd flask-qr-code-generator
   ```

2. Create a virtual environment (optional but recommended):
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```

3. Install the required packages:
   ```
   pip install -r requirements.txt
   ```

## Usage

1. Run the application:
   ```
   python run.py
   ```

2. Open your web browser and go to `http://127.0.0.1:5000`.

3. Enter the text you want to convert into a QR code on the input page and submit the form.

4. The generated QR code will be displayed on the next page.

## Dependencies

- Flask
- qrcode
- Pillow

## License

This project is licensed under the MIT License.