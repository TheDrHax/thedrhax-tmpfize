deb:
	bash build-scripts/build-deb.sh

install:
	cp src/usr/bin/tmpfize /usr/bin/tmpfize
	chmod +x /usr/bin/tmpfize

uninstall:
	rm -f /usr/bin/tmpfize

clean:
	rm *.deb
