all: client/dist

# Rules with names that aren't physical artifacts.
.PHONY: all serve watch test

client/node_modules:
	mkdir $@
e2e/node_modules:
	mkdir $@

# Install client deps.
# Touches yarn.lock in case updates don't alter the lock file
# (e.g. deleted node_modules, cosmetic package.json udates, etc).
client/yarn.lock: client/node_modules client/package.json
	cd client && yarn install
	touch $@
e2e/yarn.lock: e2e/node_modules e2e/package.json
	cd e2e && yarn install
	touch $@

# Client build.
# TODO: using find here means we won't re-run if file (page, etc.) gets deleted
# TODO: remove --debug in prod
# TODO: handle nested Page dirs (elm doesn't like **/*.elm)
client/dist: client/yarn.lock $(shell find client/src -type f) $(shell find client/public -type f) client/elm.json
	cd client; mkdir -p dist; rm -rf dist/*; cp -r public/* dist/; \
	node_modules/elm/bin/elm make --debug src/Page/*.elm --output=dist/main.js

# Run server.
# Letting `cargo run` handle building the server for now.
# May need an explicit cargo build rule if things get more complex.
serve: all
	cd server && RUSTFLAGS="--deny warnings" cargo run

# See `cargo watch --help`
# Ignoring yarn.lock to avoid double runs when it gets touched on client build.
watch:
	cargo watch --why -C server -w .. -i yarn.lock -s "$(MAKE) -C .. serve"
watch.test:
	cargo watch --why -C server -w .. -i yarn.lock -s "$(MAKE) -C .. test"

test: e2e/yarn.lock
	cd e2e && yarn e2e:run
