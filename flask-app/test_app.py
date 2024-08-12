from app import app
import pytest


@pytest.fixture
def client():
    with app.test_client() as client:
        yield client


def test_hello(client):
    response = client.get("/")
    assert response.data == b"Hello Localiza Labs!"


def test_ping(client):
    response = client.get("/ping")
    assert response.data == b"pong"
