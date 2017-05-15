from setuptools import setup

setup(
    name='web',
    version='2.0.0',
    url='http://www.4lambda.io',
    license='Apache License 2.0',
    author='4Lambda Developers',
    author_email='d@4lambda.io',
    description='Web. landing for 4Lambda.',
    install_requires=[
        'flask>0.10',
        'flask_bootstrap>3.3.0.0',
        'flask-scss>=0.5',
        'uwsgi>2.0.0',
        'supervisor>3.3.0',
        'flask_cache>0.13.0',
        'flask_compress>1.3.0',
    ],
    tests_require=[
        'flake8',
        'tox',
    ],
)
