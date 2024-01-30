Project Name Human

![Observatory](https://img.shields.io/mozilla-observatory/grade-score/abtion-rails-template.herokuapp.com)

This project is built on top of the [Abtion Rails Template](https://github.com/abtion/rails-template).

- [Getting the project running](#getting-the-project-running)
  - [Run locally using docker for database servers](#run-locally-using-docker-for-database-servers)
  - [Run entirely project locally](#run-entirely-project-locally)
  - [Run inside docker dev container](#run-inside-docker-dev-container)
- [Developing](#developing)
  - [First time setup](#first-time-setup)
    - [1. Configuration](#1-configuration)
      - [Chrome driver](#chrome-driver)
    - [3. Ensure that linting and tests pass](#3-ensure-that-linting-and-tests-pass)
    - [4. Git hooks](#4-git-hooks)
    - [5. Mails (letter\_opener)](#5-mails-letter_opener)
  - [Day-to-day](#day-to-day)
  - [Debugging](#debugging)
  - [Download production or staging DB](#download-production-or-staging-db)
  - [System specs (E2E tests)](#system-specs-e2e-tests)
    - [Switching browser driver](#switching-browser-driver)
    - [Screenshots in CI](#screenshots-in-ci)
- [Notable inclusions and Notable exclusions](#notable-inclusions-and-notable-exclusions)
  - [Devise User Authorization](#devise-user-authorization)
  - [Sidekiq](#sidekiq)
- [Production](#production)
  - [Deployments](#deployments)
- [Staging](#staging)
- [Third party services](#third-party-services)
  - [Name of the third party](#name-of-the-third-party)

Description of the project. What is it solving? Who are the users?

This section should include any business related explanation that helps understand the context of the project. It could be an excellent idea to include a dictionary of terms, a color legend or a user roles explanation.

- App: [staging](https://<project-name-param>-staging.herokuapp.com/) | [production](https://<project-name-param>-production.herokuapp.com/)
- Heroku: [staging](https://dashboard.heroku.com/apps/<project-name-param>-staging) | [production](https://dashboard.heroku.com/apps/<project-name-param>-production)
- Asana:
- URL to Abtion's own related git repositories (frontend / backend / admin area / microservices)
- Harvest:
- CI:
- Client name, and if possible, contact details.
- 1Password:
- Error Tracking:
- Activity Monitoring:
- Logging:
- Email Service:
- Client: IT person contact details

If the project is using some special external services (NemID, oAuth, Customer API, etc.) give a short description here.
Example: The app is using NemID to authenticate all its users.

# Getting the project running

There are three supported ways to run the project:

1. [Run locally using docker for database servers](#run-locally-using-docker-for-database-servers)
2. [Run entirely project locally (for non-docker purists)](#run-entirely-project-locally)
3. [Run inside docker dev container (for docker purists)](#run-inside-docker-dev-container)

## Run locally using docker for database servers

Requirements:

- docker (or podman)
- asdf

1. First set up node and ruby:

```bash
# Add nodejs and ruby plugins if you don't already have them
asdf plugin add nodejs
asdf plugin add ruby

# Install ruby and nodejs
asdf install

# Install yarn
npm install -g yarn
```

2. Then run database with docker:

```bash
docker compose up
```

3. Run setup:

```bash
bin/setup
```

The project is now ready to run locally.

## Run entirely project locally

The steps are the same as for [Run locally using docker for database servers](#run-locally-using-docker-for-database-servers) except for step 2, and `docker` is (obviously) not a requirement.

You will instead need to install the database servers and configure them correctly:

- PostgreSQL (see version in docker-compose.yml)
- Redis (see version in docker-compose.yml)

It will be necessary to configure the database connections by setting corresponding env vars.
If postgres is set up to use trust authentication (default for homebrew), then the following should be enough\*:

```bash
# .env.local
DATABASE_SERVER=""
```

\*_Caution: If you on a mac do not clear `DATABASE_SERVER`, you might get a seemingly unrelated: `+[__NSCFConstantString initialize] may have been in progress in another thread...`_

## Run inside docker dev container

Requirements:

- docker (or podman)

First get the databases and dev container running with:
`docker compose --profile dev up`

When the command prints "Dev container ready" it means that you can now connect to the dev server to do whatever you would usually do:

```bash
docker compose exec dev bash
bin/setup
rails s
```

You can connect multiple times to run multiple processes, for instance shakapacker-dev-server can be started with:
`docker compose exec dev bin/shakapacker-dev-server`

# Developing

## First time setup

### 1. Configuration

We use [dotenv](https://github.com/bkeepers/dotenv) for configuring env vars.

The following files are checked into git:

- `.env` - common configuration for development and test environments (**not production**)
- `.env.development` - configuration specific to the development environment
- `.env.test` - configuration specific to the test environment

To make local changes, create a `.env.local` file (or `.env.development.local`/`.env.test.local` for the development/test environments specifically).

#### Chrome driver

Download the correct version of chromedriver.\*

```sh
$ bin/rails webdrivers:chromedriver:update
```

\*_It will try to do this automatically when running the tests, but if you disable network with webmock/vcr your tests will fail when it does._

### 3. Ensure that linting and tests pass

Run:

```sh
bin/rspec
bin/rubocop
bin/brakeman --quiet --no-summary
bin/erblint --lint-all
yarn lint
```

Or instead, you can run `bin/test-all-strict`

### 4. Git hooks

Run: `bin/install-hooks`

This way you are getting all our git hooks for both pushing and committing.
If for some reason you don't want one of the hooks (push/commit) you can specify it by with `--no-commit` and `--no-push`.

The hooks are symlinked meaning all the changes to the repo hooks will automatically be updated in all local environments, in the case of a change.

### 5. Mails (letter_opener)

Mail sent while working in development environment is displayed with letter_opener.
To disable letter_opener set `USE_LETTER_OPENER` variable in `.env.development` file to `false` (true by default)

## Day-to-day

- Run the server: `bin/rails server` and [http://localhost:3000](http://localhost:3000)
- Run backend tests: `bin/rspec`
- Run frontend tests: `yarn test`
- Run linters: `bin/lint-fix`

Spring has also been installed for development. The binstubs have not been generated but you can run it with:

```sh
bundle exec spring rspec
```

## Debugging

- Call `byebug` anywhere in the code to stop execution and get a debugger console.
- Access an IRB console on exception pages or by using `<%= console %>` anywhere in the code.
- (Of course, [RubyMine](https://www.jetbrains.com/ruby/) includes a great [visual debugger](https://www.jetbrains.com/ruby/features/ruby_debugger.html)).

## Download production or staging DB

First of all, **don't download production data** unless absolutely necessary.
It contains personal data, and the environment you download it to must be as secure as the production environment.
Additionally, you must ensure that the data is deleted afterwards.

If for some reason you need to download production data anyway, you can use [parity](https://github.com/thoughtbot/parity).

## System specs (E2E tests)

We use [rspecs adaptor for rails system test](https://relishapp.com/rspec/rspec-rails/v/5-1/docs/system-specs/system-spec), which in turn is using [capybara](https://github.com/teamcapybara/capybara).

The configuration is kept in `spec/support/capybara.rb`.

### Switching browser driver

By default the systems specs are executed in a headless chrome browser.

To see what's going on in a spec use the `CAPYBARA_DRIVER` env var to set a non-headless browser, e.g.:

`CAPYBARA_DRIVER=chrome bin/rspec`

Available options are (as per possible names [here](https://github.com/rails/rails/blob/df1e1bc35c6210ecb39532a06823a6cf4f07bcd8/actionpack/lib/action_dispatch/system_testing/browser.rb)):

- `chrome`
- `firefox`\*
- `headless_chrome`
- `headless_firefox`\*

\* Firefox options are untested and therefore cannot be relied upon

### Screenshots in CI

When system spec fails in CI a screenshot will be saved as a Github Actions artifact. If need be you can download the `capybara.zip` file and extract it to get to the screenshots.

# Notable inclusions and Notable exclusions

Inclusions:

- [Devise](#devise-user-authorization)
- Shakapacker
- Jest
- PostgreSQL database (15.5)
- [Rollbar](https://rollbar.com) error monitoring
- Prettier for linting javascript files
- RSpec runner
  - FactoryBot
  - Capybara for acceptance testing
- Rubocop for linting ruby files
- CSP header is configured, so if you need to use remotely hosted javascript, you must whitelist it in `config/initializers/content_security_policy.rb`
- Sidekiq for running jobs
- Spring (without binstubs)

Exclusions:

- Turbolinks

## Devise User Authorization

There's a single `user` model with two user levels: **user** and **admin**.

A boolean `admin` attribute determines which of the two levels a user belongs to.

By default, only admins are authorized to call a controller action.

## Sidekiq

This project is using `Sidekiq` to run background jobs. `Sidekiq` provides a web-interface which gives a nice overview.
Default credentials for staging are:

```
user: abtion
pass: password
```

These can be set via the `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD` config-vars on heroku.

# Production

The project is hosted by [heroku](https://heroku.com).

Current dyno types and add-on plans can be found in the project's [heroku dashboard](https://dashboard.heroku.com/apps/project-name-param-production). To access the dashboard, a heroku user with access to the abtion team is required.

## Deployments

Review apps and CI are enable for PR's. Auto merge setup to staging environment on merging of branches into `main`.

Remote (App)
Staging https://git.heroku.com/project-name-param-staging-eu.git (https://project-name-param-staging-eu.herokuapp.com/)
Production https://git.heroku.com/project-name-param-production.git (https://project-name-param-production.herokuapp.com/)

# Staging

Any differences that could have with production, e.g. how are emails delivered.

# Third party services

## Name of the third party

- **Description:**
- **Auth:** Where can it be found. E.g. .env file
- **Documentation:**
- **Web interface:**
- **IT Contact person:**
