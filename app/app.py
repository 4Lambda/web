from flask import Flask
from flask import render_template
from flask import redirect
from flask_bootstrap import Bootstrap

app = Flask(__name__)
Bootstrap(app)


@app.route('/', methods=['GET'])
def landing():
    return render_template('index.html')


@app.route('/<path:attempt>')
def no(attempt):
    app.logger.debug('Denied attempt for: {0}', attempt)
    return redirect('/', 307)


if __name__ == '__main__':
    app.run()
