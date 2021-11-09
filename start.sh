#!/bin/sh

gunicorn main:app -w 2 --chdir /app/src --threads 2 --access-logfile - -b 0.0.0.0:8000
