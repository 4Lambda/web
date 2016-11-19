from flask import Flask
from flask import render_template
from flask_bootstrap import Bootstrap

app = Flask(__name__)
Bootstrap(app)


@app.route('/', methods=['GET'])
def landing():
    return render_template('index.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, threaded=True)
