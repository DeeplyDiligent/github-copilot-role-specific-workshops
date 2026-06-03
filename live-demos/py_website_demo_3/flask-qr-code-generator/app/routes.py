from flask import Flask
from flask import Blueprint, render_template, request, redirect, url_for
from app.services.qr_service import generate_qr_code
import io
import base64

app = Flask(__name__)

main = Blueprint('main', __name__)

@main.route('/', methods=['GET', 'POST'])
def input_text():
    if request.method == 'POST':
        text = request.form['text']
        return redirect(url_for('main.display_qr', text=text))
    return render_template('input.html')

@main.route('/display')
def display_qr():
    text = request.args.get('text')
    img = generate_qr_code(text)

    buffered = io.BytesIO()
    img.save(buffered, format="PNG")
    img_str = base64.b64encode(buffered.getvalue()).decode()

    return render_template('display.html', qr_code_url=f'data:image/png;base64,{img_str}')

app.register_blueprint(main)

if __name__ == '__main__':
    app.run(debug=True)