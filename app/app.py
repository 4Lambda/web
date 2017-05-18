from datetime import datetime
from datetime import timedelta

from flask import Flask
from flask import send_from_directory
from flask import make_response
from flask import redirect
from flask import render_template
from flask_bootstrap import Bootstrap
from flask_scss import Scss
from flask_compress import Compress
from flask_bootstrap import WebCDN
app = Flask(__name__)
Compress(app)
Bootstrap(app)
Scss(app)

app.extensions['bootstrap']['cdns']['jquery'] = WebCDN(
    '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/'
)

@app.route('/', methods=['GET'])
def landing():
    menu_items = ['send']
    return render_template('index.html', menu_items=menu_items, images=[])


@app.route('/<path:attempt>')
def no(attempt):
    app.logger.debug('Denied attempt for: {0}', attempt)
    return redirect('/', 307)


@app.route('/robots.txt', methods=['GET'])
def robots():
    return send_from_directory('static', 'robots.txt')


@app.route('/sitemap.xml', methods=['GET'])
def sitemap():
    pages = []
    ten_days_ago = datetime.now() - timedelta(days=10)
    for rule in app.url_map.iter_rules():
        if "GET" in rule.methods and len(rule.arguments) == 0:
            pages.append([
                rule.rule,
                ten_days_ago
            ])
    sitemap_xml = render_template('sitemap_template.xml', pages=pages)
    response = make_response(sitemap_xml)
    response.headers["Content-Type"] = "application/xml"
    return response


if __name__ == '__main__':
    app.run()
