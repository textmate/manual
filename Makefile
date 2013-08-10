PAGES = $(sort $(wildcard pages/*.md))

default: html/.generated

html/.generated: $(PAGES) bin/gen_manual Makefile
	bin/gen_manual $(PAGES) -ho html/ && touch $@

clean:
	rm -rf html

.PHONY: default clean
