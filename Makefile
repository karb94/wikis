BASE_DIR := $(abspath $(dir $(MAKEFILE_LIST)))
MD_FILES := $(shell find src/ -type f -name '*.md')
HTML_FILES := $(patsubst src/%.md, html/%.html, $(MD_FILES))
CSS_FILE := ${BASE_DIR}/src/css/style3.css

.PHONY: all

all: $(HTML_FILES)

# print:
# 	@echo ${FILES}


html/%.html: src/%.md ${CSS_FILE}
	@[ -d "$(@D)" ] || echo Creating "$(@D)" directory
	@mkdir -p "$(@D)"
	@echo Writing "$@"
	@pandoc "$<" \
		--from=markdown --to=html5 \
		--standalone \
		--css=${CSS_FILE} \
		--output="$@"

clean:
	rm -rf html
