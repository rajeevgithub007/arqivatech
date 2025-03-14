#!/bin/bash
cd /var/www/html/app || exit 1  # Exit if directory doesn't exist
sudo gunicorn --bind 0.0.0.0:80 wsgi:app --daemon
