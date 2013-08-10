PAGES = $(sort $(wildcard pages/*.md))

default: html/.generated

html/.generated: $(PAGES) bin/gen_manual Makefile
	bin/gen_manual $(PAGES) -ho html/ && touch $@

deploy: html/.generated
	bin/deploy

clean:
	rm -rf html

.PHONY: default deploy clean
