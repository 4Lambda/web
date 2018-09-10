from flask import Flask
from flask import Response
from flask import redirect
from flask import render_template
from flask import send_from_directory
from flask import url_for
from flask_bootstrap import Bootstrap
from flask_scss import Scss

app = Flask(__name__)
Bootstrap(app)
Scss(app)


@app.route('/', methods=['GET'])
def landing() -> Response:
    """
    Returns the main landing page.
    :returns: A Response containing the main landing page.
    """
    menu_items = ['send']
    return render_template('index.html', menu_items=menu_items, images=[])


@app.route('/robots.txt', methods=['GET'])
def robots() -> Response:
    """
    Returns the robots.txt file for online bots.
    :returns: A Response containing the robots.txt file.
    """
    return send_from_directory('static', 'robots.txt')


@app.route('/<path:attempt>')
def no(attempt) -> Response:
    """
    Redirects all requests to the root.
    :param attempt: The path attempted.
    :returns: A Response redirecting the user to the main landing.
    """
    app.logger.debug('Denied attempt for: {0}', attempt)
    return redirect(url_for('landing'), 307)
