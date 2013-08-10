PAGES = $(sort $(wildcard pages/*.md))

default: html/.generated

html/.generated: $(PAGES) html/styles.css bin/gen_manual Makefile
	bin/gen_manual $(PAGES) -ho html/ && touch $@

html/styles.css: pages/styles.css
	cp $< $@

deploy: html/.generated
	bin/deploy

clean:
	rm -rf html

.PHONY: default deploy clean
