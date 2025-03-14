#!/bin/bash
cd /var/www/html
gunicorn --bind 0.0.0.0:80 wsgi:app --daemon
