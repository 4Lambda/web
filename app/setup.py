from setuptools import setup

setup(
    name='web',
    version='2.0.0',
    url='http://www.4lambda.io',
    license='Apache License 2.0',
    author='4Lambda Developers',
    author_email='d@4lambda.io',
    description='Technology Partner.',
    install_requires=[
        'flask >=0.12.0, <0.13.0',
        'flask_bootstrap >=3.3.7.1, <3.3.8.0',
        'flask_cache >=0.13.1, <0.14.0',
        'flask_compress >=1.4.0, <1.5.0',
        'flask_scss==0.5',
        'uwsgi >=2.0.15, <2.1.0',
        'supervisor >=3.3.0, <3.4.0',
    ],
    tests_require=[
        'flake8',
        'tox',
    ],
)
