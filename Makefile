PAGES = $(wildcard pages/*.md)

all: html/.generated

html/.generated: $(PAGES)
	bin/gen_manual $^ -o html/ && touch $@

clean:
	rm -rf html

.PHONY: all clean
