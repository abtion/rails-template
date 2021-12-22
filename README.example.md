Project Name Human

![Observatory](https://img.shields.io/mozilla-observatory/grade-score/muffi-template.herokuapp.com)

This project is built on top of [Muffi](https://github.com/abtion/muffi).

1. [Project Name Human](#Project-Name-Human)
2. [Requirements](#requirements)
3. [Developing](#developing)
   - [First time setup](#first-time-setup)
     - [1. Configuration](#1-configuration)
       - [Database connection](#database-connection)
     - [2. Dependencies and database setup](#2-dependencies-and-database-setup)
       - [Chrome driver](#chrome-driver)
     - [3. Ensure that linting and tests pass](#3-ensure-that-linting-and-tests-pass)
     - [4. Git hooks](#4-git-hooks)
     - [5. Mails (letter_opener)](#5-mails-letter_opener)
   - [Day-to-day](#day-to-day)
   - [Debugging](#debugging)
   - [Download production or staging DB](#download-production-or-staging-db)
4. [Notable inclusions and Notable exclusions](#notable-inclusions-and-notable-exclusions)
   1. [Devise User Authorization](#devise-user-authorization)
5. [Production](#production)
   1. [Deployments](#deployments)
6. [Staging](#staging)
7. [Third party services](#third-party-services)
   1. [Name of the third party](#name-of-the-third-party)

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

# Requirements

You must have the following installed and available on your machine:

- **Ruby 3.0.x**
- **Node JS 16.x**
- **Yarn 1.x**
- **PostgreSQL 12**
- **Redis**

# Developing

## First time setup

### 1. Configuration

We use [dotenv](https://github.com/bkeepers/dotenv) for configuring env vars.

The following files are checked into git:

- `.env` - configuration common across all environments
- `.env.development` - configuration specific to the development environment
- `.env.test` - configuration specific to the test environment

If you need to make local changes to the env files, create a `.env.ENVIRONMENT.local` file (where ENVIRONMENT is test or development).

Any env var you specify in such a file will override the configuration for the corresponding environment.

#### Database connection

You can set `DATABASE_SERVER` in `.env.local`, if you for instance use Docker for Postgres: `DATABASE_SERVER="postgresql://localhost:5432"`
Or if you just use a local postgres instance:
`DATABASE_SERVER=postgresql://user:pass@localhost:5432`

### 2. Dependencies and database setup

Run: `bin/setup`

#### Chrome driver

Download the correct version of chromedriver.\*

```sh
$ bundle exec rails webdrivers:chromedriver:update
```

\*_It will try to do this automatically when running the tests, but if you disable network with webmock/vcr your tests will fail when it does._

If you need to, you can disable the Chrome driver by setting
`DISABLE_WEBDRIVERS` to `true` in `.env.test` or running
`DISABLE_WEBDRIVERS=true bundle exec rspec` if you only need to do it
occasionally.

### 3. Ensure that linting and tests pass

Run:

```sh
bundle exec rspec
bundle exec rubocop
bundle exec brakeman --quiet --no-summary
bundle exec erblint --lint-all
bundle exec bundle-audit update
bundle exec bundle-audit
yarn lint
```

Or instead, you can run `rails test_all_strict`

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
- Run tests: `bundle exec rspec`
- Run backend linters: `bin/rails lint_fix`
- Run frontend linters: `yarn lint-fix`

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

# Notable inclusions and Notable exclusions

Inclusions:

- [Devise](#devise-user-authorization)
- Webpacker
- Jest
- PostgreSQL database (11.x)
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
