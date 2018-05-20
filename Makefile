chrome:
	python build.py devenv -t chrome
firefox:
	python build.py build -t gecko
clean:
	rm -r devenv.*
	rm -r *.xpi
