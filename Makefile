.PHONY: browser jupyter setup

browser:
	PYTHONPATH=`pwd` screen .venv/bin/jupyter notebook --ip 0.0.0.0 --port=8833 --no-browser .

jupyter:
	PYTHONPATH=`pwd` screen .venv/bin/jupyter notebook --ip 0.0.0.0 --port=8833 .

setup:
	test -d .venv || python3 -m venv .venv
	.venv/bin/pip install -U pip
	.venv/bin/pip install -r requirements.txt


back:
	screen ./backend.sh
front:
	screen ./frontend.sh
