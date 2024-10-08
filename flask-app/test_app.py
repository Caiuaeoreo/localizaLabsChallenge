from app import app
import pytest


@pytest.fixture
def client():
    with app.test_client() as client:
        yield client


def test_hello(client):
    response = client.get("/")
    assert response.status_code == 200  # nosec
    assert response.data == b"Hello Localiza Labs!"  # nosec


def test_ping(client):
    response = client.get("/ping")
    assert response.status_code == 200  # nosec
    assert response.data == b"pong"  # nosec


# End of code
