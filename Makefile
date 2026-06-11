SHELL := /bin/bash
DRAFT ?= draft-jiang-intent-security-00

# Source XML at repo root
SRC_XML := $(DRAFT).xml

# Build outputs
XML   := build/$(DRAFT).xml
TXT   := build/$(DRAFT).txt
HTML  := build/$(DRAFT).html
INDEX := build/index.html

XML2RFC ?= xml2rfc

.PHONY: all clean check html txt xml index build

all: html txt index

build:
	@mkdir -p build

# Copy source XML into build/ for publishing
xml: build $(SRC_XML)
	@cp -f $(SRC_XML) $(XML)

html: xml
	$(XML2RFC) --html -o $(HTML) $(XML)

txt: xml
	$(XML2RFC) --text -o $(TXT) $(XML)

check: xml
	$(XML2RFC) --strict --quiet $(XML) >/dev/null

# If you want GitHub Pages root to show the draft HTML:
index: html
	@cp -f $(HTML) $(INDEX)

clean:
	rm -rf build
