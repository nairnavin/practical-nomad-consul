from rediscluster import RedisCluster
from flask import Flask

startup_nodes = [{"host": "localhost", "port": "6005"}]

# Note: decode_responses must be set to True when used with python3
rc = RedisCluster(startup_nodes=startup_nodes, decode_responses=True)
PORT = 8000
rc.set("foo", "Hello from Python from Terminating gateway!")

MESSAGE = rc.get("foo")


app = Flask(__name__)


@app.route("/")
def root():
    result = MESSAGE.encode("utf-8")
    return result


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=PORT)