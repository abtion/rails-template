# Project Name Human

![Observatory](https://img.shields.io/mozilla-observatory/grade-score/abtion-rails-template.herokuapp.com)

This project is built on top of the [Abtion Rails Template](https://github.com/abtion/rails-template).

- [Development](#development)
  - [Requirements](#requirements)
  - [Configuration](#configuration)
    - [Environment](#environment)
    - [Git hooks (optional)](#git-hooks-optional)
  - [Setup](#setup)
    - [Other setups](#other-setups)
    - [Available scripts](#available-scripts)
  - [Good to know](#good-to-know)
    - [Notable inclusions and exclusions](#notable-inclusions-and-exclusions)
    - [Development admin credentials](#development-admin-credentials)
    - [Sidekiq](#sidekiq)
    - [Deployments](#deployments)
    - [Third party services](#third-party-services)

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

## Development

### Requirements

- [Docker](https://www.docker.com/get-started/)
- [ASDF](https://asdf-vm.com/guide/getting-started.html) (plugins defined in [.tool-versions](./.tool-versions))

### Configuration

#### Environment

We use [dotenv](https://github.com/bkeepers/dotenv#customizing-rails) for configuring env vars.

#### Git hooks (optional)

Git hooks defined in [install-hooks](./bin/install-hooks)

```sh
bin/install-hooks
```

### Setup

The recommended way to run the project is to use `docker compose` for databases and `asdf` for installing runtimes.\

For running the project locally:

1. In one terminal window:

    ```sh
    docker compose up
    ```

2. In another terminal window:

    ```sh
    asdf install # To install runtimes
    bin/setup # To install dependencies and initialize the database
    bin/rails s # To run the webserver
    ```

3. The project can now be accessed at <http://localhost:3000>

#### Other setups

It is also possible to run everything locally, but it requires locally setting up the services specified in the [docker-compose.yml](docker-compose.yml).\
It will also require changes to the connection string env vars.

#### Available scripts

Checkout the [bin](./bin/) for scripts and binstubs \
[package.json](./package.json) also contains a few frontend specific scripts

Commonly used:

```sh
bundle install # Install ruby gems
npm install # Install frontend dependencies
bin/rspec # Run rails tests
npm run test # Run frontend tests
bin/lint # Run all linters
bin/lint-fix # Run all linters and attempt to fix problems
bin/test-all-strict # Run all tests and linters
bin/shakapacker-dev-server # Watch for frontend changes and compile on the go
```

Spring is also available for development. Since using spring can cause hard-to-debug errors, the binstubs are not springifie, but you can run easily spring with `bin/spring [command]`, e.g.:

```sh
bin/spring rspec
bin/spring rails s
```

## Good to know

### Notable inclusions and exclusions

Inclusions:

- [Devise](https://github.com/heartcombo/devise) for authentication
- [Pundit](https://github.com/varvet/pundit) for authorization
- [Shakapacker](https://github.com/shakacode/shakapacker)
- [Jest](https://jestjs.io/)
- [Rollbar](https://rollbar.com) error monitoring
- [Prettier](https://prettier.io/) for linting javascript files
- [RSpec](https://rspec.info/)
  - [FactoryBot](https://github.com/thoughtbot/factory_bot)
  - [Capybara](https://github.com/teamcapybara/capybara) for system specs
- [Rubocop](https://github.com/rubocop/rubocop) for linting ruby files
- [Sidekiq](https://github.com/sidekiq/sidekiq) for running jobs
- [Spring](https://github.com/rails/spring) (without binstubs)

Exclusions:

- Turbolinks

### Development admin credentials

```txt
user: admin@example.com
password: password
```

### Screenshots in CI

When system spec fails in CI a screenshot will be saved as a Github Actions artifact. If need be you can download the `capybara.zip` file and extract it to get to the screenshots.

### Sidekiq

`Sidekiq` provides useful web-interface (available at [/sidekiq](http://localhost:3000/sidekiq)).

For staging/production envs, username and password are set with - and can be found in - env vars `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD` for the respective envs.

### Deployments

Commits to `main` are automatically deployed to the staging environment (after they've passed [CI](.github/workflows/ci.yml)).
Deployments to production happen by promoting the staging environment.

### Third party services

#### Name of the third party

- **Description:**
- **Auth:** Where can it be found. E.g. .env file
- **Documentation:**
- **Web interface:**
- **IT Contact person:**
