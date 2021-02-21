#!/usr/bin/env bash

set -o errexit

if [[ ! -d "app/staticfiles" ]]; then .venv/bin/python app/manage.py collectstatic --noinput; fi

.venv/bin/python app/manage.py wait_for_db
.venv/bin/python app/manage.py migrate
#.venv/bin/python app/manage.py create_roles

#if [[ -n "${ADMIN_USERNAME}" ]] && [[ -n "${ADMIN_EMAIL}" ]] && [[ -n "${ADMIN_PASSWORD}" ]]; then
#  .venv/bin/python app/manage.py create_admin --noinput --username="${ADMIN_USERNAME}" --email="${ADMIN_EMAIL}" --password="${ADMIN_PASSWORD}"
#fi

.venv/bin/gunicorn --bind="0.0.0.0:${PORT:-8500}" --workers="${WORKERS:-1}" --pythonpath=app app.wsgi --timeout 300
