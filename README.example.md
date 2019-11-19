# README

This project is built on top of [Muffi](https://github.com/abtion/muffi).

## Developing

### Getting Started

* After cloning this repo, run: `bin/setup`

### Day-to-day

* Run the server: `heroku local` and [http://localhost:5000](http://localhost:5000)
* Run tests: `rspec`

### Debugging

* Call `byebug` anywhere in the code to stop execution and get a debugger console.
* Access an IRB console on exception pages or by using `<%= console %>` anywhere in the code.
* (Of course, [RubyMine](https://www.jetbrains.com/ruby/) includes a great [visual debugger](https://www.jetbrains.com/ruby/features/ruby_debugger.html)).

### HerokuCI green builds deploy to Heroku staging servers

## What's Included

### Simple User Authorization

There are 2 user levels: **admin**, **user**. **Admins** are users whose `admin` flag is set.
**user** are users who aren't admins.

By default, only admins are authorized to call a controller action.

# Name of the project

1. [README](#readme)
   1. [Developing](#developing)
      1. [Getting Started](#getting-started)
      2. [Day-to-day](#day-to-day)
      3. [Debugging](#debugging)
      4. [HerokuCI green builds deploy to Heroku staging servers](#herokuci-green-builds-deploy-to-heroku-staging-servers)
   2. [What's Included](#whats-included)
      1. [Simple User Authorization](#simple-user-authorization)
2. [Name of the project](#name-of-the-project)
3. [Development](#development)
   1. [Requirements](#requirements)
   2. [Set up the app the first time](#set-up-the-app-the-first-time)
   3. [Run the app](#run-the-app)
   4. [Run the tests](#run-the-tests)
   5. [Download production or staging DB](#download-production-or-staging-db)
   6. [Notable inclusions and Notable exclusions](#notable-inclusions-and-notable-exclusions)
4. [Production](#production)
      1. [Heroku](#heroku)
   1. [Deployments](#deployments)
5. [Staging](#staging)
6. [Third party services](#third-party-services)
   1. [Name of the third party](#name-of-the-third-party)
7. [Conventions](#conventions)

Description of the project. What is it solving? Who are the users?

URL to the project
Asana:
URL to Abtion's own related git repositories (frontend / backend / admin area / microservices)
Harvest:
Travis:
Client name, and if possible, contact details including IT contact details
Name, and a short description of any services that the project is using (error tracking, activity monitoring, log registry, email service, etc). Include where to get the credentials. E.g., 1Password under admin+project@abtion.com.

This section should include any business related explanation that helps understand the context of the project. It could be an excellent idea to include a dictionary of terms, a color legend or a user roles explanation.

# Development

There are two main configuration files that are of concern:

- `.env` - configuration that's common across all environments that you intend
  to run on your machine (e.g. database connection)
- `.env.development` - configuration that's specific to the development
  environment that you intend to run on your machine (e.g. API credentials)

There exists a `.env.test` which is checked in to source control, used to
configure the test equivalents for whatever is in `.env.development`. As tests
will be written such that they don't make any calls to external services, **it
should not contain any real credentials.** Instead, use dummy credentials and
stub any external calls using the test suite's features.

Setting up the configuration is a matter of copying the supplied examples and
filling in the gaps, as follows:


## Requirements

You must have the following installed and available on your machine:

- **Ruby 2.6.5**
- **Node JS 12.x**
- **PostgreSQL 11.3**

## Set up the app the first time
```sh
$ cp .env.example .env
# edit .env in your editor of choice

$ cp .env.development.example .env.development
# edit .env.development in your editor of choice
```

Install the Ruby and JS dependencies

```sh
$ bundle install
$ npm install -g yarn
$ yarn install
```

Prepare the database

You can set `DATABASE_URL` in `.env.local`, if for instance you use Docker for Postgres. `DATABASE_URL="postgresql://localhost:5432"`
```sh
$ bundle exec rails db:setup
```

Download the correct version of chromedriver, it will try to do it automatically, but if you disable network with webmock/vcr your tests will fail when it does.
```sh
$ bundle exec rails webdrivers:chromedriver:update
```

Run the test suite and expect all tests to pass

```sh
$ bundle exec rspec
```

Start a development server and check out the app in a browser

```sh
heroku local
```

## Run the app

`bundle exec rails s`

## Run the tests

`bundle exec rspec`

## Download production or staging DB

Use [parity](https://github.com/thoughtbot/parity)

## Notable inclusions and Notable exclusions
Inclusions:
- Webpacker
- PostgreSQL database (11.x)
- RSpec runner
  - FactoryBot
  - Capybara for acceptance testing

Exclusions:

- No Spring
- No Turbolinks

# Production

### Heroku

Dynos - EU location, Heroku-18 stack
Postgres - Hobby Dev $7 in staging and Standard $50 in production

## Deployments

Using Heroku review apps and CI. Auto merge setup to staging environment on merging of branches into master.

Remote (App)
Staging https://git.heroku.com/PROJECT_NAME-staging-eu.git (https://PROJECT_NAME-staging-eu.herokuapp.com/)
Production https://git.heroku.com/PROJECT_NAME-production.git (https://PROJECT_NAME-production.herokuapp.com/)

# Staging

Any differences that could have with production, e.g. how are emails delivered.

# Third party services

## Name of the third party

- **Description:**
- **Auth:** Where can it be found. E.g. .env file
- **Documentation:**
- **Web interface:**
- **IT Contact person:**

# Conventions

This document and other documentation in this project may use the following
conventions:

**`$`** is used to denote commands that are executed in your shell
(zsh/fish/bash etc.)

**`>`** is used to denote commands that are executed in a REPL or other
interactive tool (e.g. ruby console, psql session.)

**`#`** is used to annotate the instructions or describe what the reader will
see when the instructions are followed. It doesn't hold any functional
significance.

For example:

```sh
$ bundle exec irb
> puts "foo"
# you'll see ruby repeat "foo" back to you
> exit

$ psql -h localhost
> select * from table;
```

Context will often indicate what the `>` prompt represents, but it may be
represented in unambiguous ways such as:

```sh
$ bundle exec irb
(irb)> puts "foo"
# you'll see ruby repeat "foo" back to you
(irb)> exit

$ psql -h localhost
(psql)> SELECT * FROM table;
```
