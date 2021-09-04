# Elm + Rust starter

Project template for an elm app with a rust server (using actix-web).

The elm app is not a SPA. Every request goes through the rust server.
This is by choice to keep things simple and is plenty fast enough.

- `/client`: elm-pages frontend (should work fully offline as a pwa?)
- `/server`: rust+rocket app serving the client app and api
- `/e2e`: cypress E2E tests
- Each dir above has its own isolated package/dependency setup.
- Everything is orchestrated with a root Makefile

**Get started:**

- Pre-reqs: [rust](https://www.rust-lang.org/tools/install), [yarn](https://classic.yarnpkg.com/en/docs/install/), and `make`
- Run `make serve`
- Open <http://localhost:8000/>

or to automatically build/restart server on file changes:

- Pre-req: `cargo install cargo-watch`
- Run `make watch`

**Tests**

Drive all development test-first as much as possible.

- Elm tests live in `client/`
- Rust tests live in `server/`
- End-to-end tests using [cypress](https://www.cypress.io/) live in `e2e/`

Run everything with: `make test`

_Set this up as a pre-commit hook. No commits with non-green tests on `main`!_
