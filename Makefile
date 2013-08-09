PAGES = $(sort $(wildcard pages/*.md))

default: html/.generated

html/.generated: $(PAGES) | bin/gen_manual
	bin/gen_manual $^ -o html/ && touch $@

clean:
	rm -rf html

.PHONY: default clean
