MD_FILES := $(shell find src/ -type f -name '*.md')
HTML_FILES := $(patsubst src/%.md, html/%.html, $(MD_FILES))

.PHONY: all

all: $(HTML_FILES)

# print:
# 	@echo ${FILES}

base_dir := $(abspath $(dir $(MAKEFILE_LIST)))

html/%.html: src/%.md
	@[ -d "$(@D)" ] || echo Creating "$(@D)" directory
	@mkdir -p "$(@D)"
	@echo Writing "$@"
	@pandoc "$<" \
		--from=markdown --to=html5 \
		--standalone \
		--css=${base_dir}/src/style.css \
		--output="$@"

clean:
	rm -rf html
