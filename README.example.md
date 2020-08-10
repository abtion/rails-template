# PROJECT_NAME_HUMAN

This project is built on top of [Muffi](https://github.com/abtion/muffi).

1. [PROJECT_NAME_HUMAN](#project_name_human)
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
- **PostgreSQL 11.3**

# Developing

## First time setup

### 1. Configuration

There are two main configuration files that are of concern:

- `.env` - configuration that's common across all environments that you intend
  to run on your machine (e.g. [database connection](#database-connection))
- `.env.development` - configuration that's specific to the development
  environment that you intend to run on your machine (e.g. API credentials)

There exists a `.env.test` which is checked in to source control, used to
configure the test equivalents for whatever is in `.env.development`. As tests
will be written such that they don't make any calls to external services, **it
should not contain any real credentials.** Instead, use dummy credentials and
stub any external calls using the test suite's features.

Setting up the configuration is a matter of copying the supplied examples and
filling in the gaps, as follows:

1. `cp .env.example .env`
2. `cp .env.development.example .env.development`
3. Fill in env vars that are local to your setup

#### Database connection

You can set `DATABASE_URL` in `.env`, if for instance you use Docker for Postgres. `DATABASE_URL="postgresql://localhost:5432"`

### 2. Dependencies and database setup

Run: `bin/setup`

#### Chrome driver

Download the correct version of chromedriver.\*

```sh
$ bundle exec rails webdrivers:chromedriver:update
```

\*_It will try to do this automatically when running the tests, but if you disable network with webmock/vcr your tests will fail when it does._

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
- PostgreSQL database (11.x)
- RSpec runner
  - FactoryBot
  - Capybara for acceptance testing

Exclusions:

- Spring
- Turbolinks

## Devise User Authorization

There's a single `user` model with two user levels: **user** and **admin**.

A boolean `admin` attribute determines which of the two levels a user belongs to.

By default, only admins are authorized to call a controller action.

# Production

The project is hosted by [heroku](https://heroku.com).

Current dyno types and add-on plans can be found in the project's [heroku dashboard](https://dashboard.heroku.com/apps/PROJECT_NAME_PARAM-production). To access the dashboard, a heroku user with access to the abtion team is required.

## Deployments

Review apps and CI are enable for PR's. Auto merge setup to staging environment on merging of branches into `main`.

Remote (App)
Staging https://git.heroku.com/PROJECT_NAME_PARAM-staging-eu.git (https://PROJECT_NAME_PARAM-staging-eu.herokuapp.com/)
Production https://git.heroku.com/PROJECT_NAME_PARAM-production.git (https://PROJECT_NAME_PARAM-production.herokuapp.com/)

# Staging

Any differences that could have with production, e.g. how are emails delivered.

# Third party services

## Name of the third party

- **Description:**
- **Auth:** Where can it be found. E.g. .env file
- **Documentation:**
- **Web interface:**
- **IT Contact person:**
