# Project Name Human

![Observatory](https://img.shields.io/mozilla-observatory/grade-score/muffi-template.herokuapp.com)

This project is built on top of [Muffi](https://github.com/abtion/muffi).

1. [Project Name Human](#Project-Name-Human)
2. [Requirements](#requirements)
3. [Developing](#developing)
   1. [First time setup](#first-time-setup)
      1. [1. Configuration](#1-configuration)
         1. [Database connection](#database-connection)
      2. [2. Dependencies and database setup](#2-dependencies-and-database-setup)
         1. [Chrome driver](#chrome-driver)
      3. [3. Ensure that tests pass](#3-ensure-that-tests-pass)
   2. [Day-to-day](#day-to-day)
   3. [Debugging](#debugging)
   4. [Download production or staging DB](#download-production-or-staging-db)
4. [Notable inclusions and Notable exclusions](#notable-inclusions-and-notable-exclusions)
   1. [Devise User Authorization](#devise-user-authorization)
5. [Production](#production)
   1. [Deployments](#deployments)
6. [Staging](#staging)
7. [Third party services](#third-party-services)
   1. [Name of the third party](#name-of-the-third-party)

Description of the project. What is it solving? Who are the users?

This section should include any business related explanation that helps understand the context of the project. It could be an excellent idea to include a dictionary of terms, a color legend or a user roles explanation.

- URL to the project
- Asana:
- URL to Abtion's own related git repositories (frontend / backend / admin area / microservices)
- Harvest:
- CI:
- Client name, and if possible, contact details.
- IT person contact details

Name, and a short description of any services that the project is using (error tracking, activity monitoring, log registry, email service, etc). Include where to get the credentials. E.g., 1Password under admin+project@abtion.com.

# Requirements

You must have the following installed and available on your machine:

- **Ruby 2.6.6**
- **Node JS 12.x**
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

You can set `DATABASE_URL` in `.env.local`, if you for instance use Docker for Postgres: `DATABASE_URL="postgresql://localhost:5432"`
Or if you just use a local postgres instance:
`DATABASE_URL=postgresql://user:pass@localhost:5432`

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

### 3. Ensure that tests pass

Run: `bundle exec rspec`

## Day-to-day

- Run the server: `heroku local` and [http://localhost:5000](http://localhost:5000)
- Run tests: `bundle exec rspec`

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
- RSpec runner
  - FactoryBot
  - Capybara for acceptance testing
- [Rollbar](https://rollbar.com) error monitoring
- CSP header is configured, so if you need to use remotely hosted javascript, you must whitelist it in `config/initializers/content_security_policy.rb`
- Sidekiq for running jobs

Exclusions:

- Spring
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
While the production credentials live in `1Password` under `Selfcast-Sidekiq`.

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
