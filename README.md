[![Maintainability](https://api.codeclimate.com/v1/badges/d0e13853fa82d32e650a/maintainability)](https://codeclimate.com/repos/5dcbb7cd09f28e014c00f396/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d0e13853fa82d32e650a/test_coverage)](https://codeclimate.com/repos/5dcbb7cd09f28e014c00f396/test_coverage)

# Muffi

1. [Muffi](#muffi)
   1. [What is Muffi?](#what-is-muffi)
   2. [Key features](#key-features)
   3. [Getting Started](#getting-started)
      1. [Start a new project](#start-a-new-project)
      2. [Configure the project](#configure-the-project)
      3. [Configure Code Climate](#configure-code-climate)
      4. [Configure CD](#configure-cd)
      5. [Configure i18n tasks](#configure-i18n-tasks)
      6. [Setup mailing](#setup-mailing)
      7. [Setup basic auth](#setup-basic-auth)
      8. [Capybara drivers](#capybara-drivers)
      9. [Capybara Screenshots in CI](#capybara-screenshots-in-ci)
      10. [Set up Dependabot](#set-up-dependabot)
   4. [Contributing](#contributing)
   5. [License](#license)
   6. [About Abtion](#about-abtion)

## What is Muffi?

Muffi is a project template maintained by [Abtion](https://abtion.com/) and used to kick start
Ruby on Rails applications.

## What are the benefits of using Muffi

* Much less time spent on "first time setup"
* Lots of decisions are already made
* User login is there from the start
* Fully functional test setup
* Easy for developers to switch between similar projects

## Key features

* Heroku ready - Review apps, staging and production
* Uses [devise](https://github.com/plataformatec/devise)
* Uses [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions)
* Uses [Jest](https://github.com/facebook/jest)
* Uses [rspec](https://github.com/rspec/rspec-rails)
* Uses [rubocop](https://github.com/bbatsov/rubocop)
* Uses [simplecov](https://github.com/colszowka/simplecov)
* Uses [i18n-tasks](https://github.com/glebm/i18n-tasks)

## Getting Started

### Start a new project

To start a new project with Muffi, simply create a new repository on GitHub
using this repository as a template.

Alternatively, clone this repository and change the git remote to point to
your own repository.

### Configure the project

1. Edit `application.rb` and change the module name and configuration settings.
2. Edit the database names in `database.yml`
3. Use script for replacing `ProjectNamePascal` e.g. in all files:
   - `bin/replace-project-names` (uses the folder name)
   - Or `bin/replace-project-names <param-case-name>`
4. `mv README.example.md README.md`

### Configure Code Climate

1. Login to CodeClimate and add your project
2. Go to the `Repo Settings` -> `Test coverage`
3. Enable `Enforce Diff Coverage` with a threshold of 100%
4. Copy the `TEST REPORTER ID`
5. Visit `https://github.com/abtion/<Project name>/settings/secrets`
6. Add a new secret: `CC_TEST_REPORTER_ID` with the copied value from codeclimate

### Configure CD

1. Log in to the [Heroku dashboard](https://dashboard.heroku.com)
2. Create a Pipeline, and two new applications
    - Staging: `<PROJECT-NAME>-staging`
    - Production: `<PROJECT-NAME>-production`
3. Turn on "Review Apps" from the Pipeline's page
4. Set Heroku config vars:
   - `MAIL_FROM` (review, staging and production).
   - `DOMAIN_NAME` (ONLY staging and production)
   - `SEED_ADMIN_EMAIL` (review)
   - `SEED_ADMIN_INITIAL_PASSWORD` (review)

### Configure i18n tasks

If you need to ignore specific translation keys, follow this process:

1. Open `config/i18n-tasks.yml`.
2. Go to `ignore_unused` or `ignore_missing` depending on whether you need to
   ignore unused translations, e.g., if a gem adds new translation keys, or
   missing translations.
3. Add your key(s) to the section in the YAML file.
4. See the configuration file for examples on more advanced usages.

### Setup mailing

1. Go to the production app in the Heroku dashboard.
2. Add Sendgrid addon.
3. Click the added Sendgrid resource, go through the confirmation steps.
4. Set up DKIM on the client's domain (under sender authentication -> domain authentication).
5. Go to staging and repeat the above steps.
6. If you want the review apps to send emails: Copy the staging app's Sendgrid credentials and add them to the review apps config vars. Do not add the Sendgrid addon to review apps in `app.json` (Sendgrid will ban our account).

### Setup basic auth

For added security we want to add basic auth to our review/staging environments.

1. Go to the Review/Staging app in the Heroku dashboard.
2. Add environment variables for:
  1. `HTTP_AUTH_USERNAME`
  2. `HTTP_AUTH_PASSWORD`

### Capybara drivers

This project registers two Capybara drivers.

Set the environment variable `CAPYBARA_DRIVER` to `headless_chrome` (default) to run specs without
opening Chrome, or use `chrome` to open the browser automatically.

### Capybara Screenshots in CI

When a spec using Capybara fails in CI a screenshot will be saved under Github Actions Artifacts. If need be you can download the `capybara.zip` file and extract it to get to the screenshots.

### Set up Dependabot

To allow Dependabot to auto-merge security updates, you need to add a secret
token to the settings of your project on GitHub. Follow these steps:

1. Go to "Settings" > "Secrets".
2. Click "New secret".
3. Set the name to `DEPENDABOT_TOKEN` and insert a secret key (must be maximum
   64 kb).
4. Click "Add secret".

## Contributing

Muffi is maintained by [_Abtioneers_](#about-abtion), but open for anyone to suggest improvements and bugfixes.

One abtioneer is currently responsible for the project at Abtion, with support from other employees.

Please see [CONTRIBUTING.md](https://github.com/abtion/muffi/blob/main/CONTRIBUTING.md).

## License

[MIT](https://opensource.org/licenses/MIT)

## About Abtion

[![Abtion](abtion.png "Abtion")](https://abtion.com/)

[Abtion](https://abtion.com/) is a technology company building software and
services that make life better, easier and more fun. Zeros and ones are the
backbone of our work, and together with a diverse mix of designers, developers
and strategists, we create websites, mobile- and web applications with a purpose.
