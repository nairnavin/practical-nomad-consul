import redis
from flask import Flask


redis = redis.Redis(host= 'localhost', port= '6005')
# Note: decode_responses must be set to True when used with python3
redis.set('mykey', 'Hello from Python from Redis Envoy Proxy Node!')
PORT = 8000


MESSAGE = redis.get('mykey') 


app = Flask(__name__)


@app.route("/")
def root():
    result = MESSAGE
    return result


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=PORT)