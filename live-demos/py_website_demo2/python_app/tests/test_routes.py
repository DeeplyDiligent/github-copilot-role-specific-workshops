import pytest
from flask import url_for
from app import create_app

@pytest.fixture
def app():
    app = create_app()
    app.config.update({
        "TESTING": True,
    })
    return app

@pytest.fixture
def client(app):
    return app.test_client()

@pytest.fixture
def runner(app):
    return app.test_cli_runner()

def test_home_page(client):
    response = client.get(url_for('main.home'))
    assert response.status_code == 200
    assert b"<title>Home</title>" in response.data

def test_generate_qr(client):
    data = {"data": "https://example.com"}
    response = client.post(url_for('main.generate_qr'), data=data)
    assert response.status_code == 200
    assert b"QR Code Generated" in response.data