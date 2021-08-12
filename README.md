[![Maintainability](https://api.codeclimate.com/v1/badges/d0e13853fa82d32e650a/maintainability)](https://codeclimate.com/repos/5dcbb7cd09f28e014c00f396/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d0e13853fa82d32e650a/test_coverage)](https://codeclimate.com/repos/5dcbb7cd09f28e014c00f396/test_coverage)

# Muffi

1. [Muffi](#muffi)
   1. [What is Muffi?](#what-is-muffi)
      1. [What are the benefits of using Muffi?](#what-are-the-benefits-of-using-muffi)
      2. [Muffi challenges](#muffi-challenges)
   2. [Key features](#key-features)
   3. [Getting Started](#getting-started)
      1. [Start a new project](#start-a-new-project)
      2. [Replace license](#replace-license)
      3. [Configure the project](#configure-the-project)
      4. [Configure Code Climate](#configure-code-climate)
      5. [Configure CD](#configure-cd)
      6. [Configure i18n tasks](#configure-i18n-tasks)
      7. [Setup mailing](#setup-mailing)
      8. [Setup basic auth](#setup-basic-auth)
      9. [Capybara drivers](#capybara-drivers)
      10. [Capybara Screenshots in CI](#capybara-screenshots-in-ci)
      11. [Set up Dependabot](#set-up-dependabot)
   4. [Contributing](#contributing)
   5. [License](#license)
   6. [About Abtion](#about-abtion)

## What is Muffi?

Muffi is a project template maintained by [Abtion](https://abtion.com/) and used to kick start
Ruby on Rails applications.

### What are the benefits of using Muffi?

- Much less time spent on "first-time setup":
  - Projects starting from the Muffi template include all the libraries we typically use at Abtion on the latest version.
  - Basic functionality is there from the start; we can have the app live from the moment we start, start sending emails, or log in with a user to the system.
- Lots of decisions are already made:
  - We've made these same decisions many times - now we know which decisions are the right ones.
- Fully functional test setup.
  - Tests are not an afterthought. They are an integrated part of the development flow.
  - Reliable software from day one.
- Easy for developers to switch between similar projects.
  - Easy to scale projects up and down. Developers know what to expect when they join the project. They've seen similar things before.
  - Less reliance on specific people - the whole team can contribute even when a team member is not present.

### Muffi challenges

- We want to be open to multiple unknown futures, with one single template.
- It is difficult to decide what belongs to Muffi (feature creep)

## Key features

- Heroku ready - Review apps, staging and production
- Uses [devise](https://github.com/plataformatec/devise)
- Uses [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions)
- Uses [Jest](https://github.com/facebook/jest)
- Uses [rspec](https://github.com/rspec/rspec-rails)
- Uses [rubocop](https://github.com/bbatsov/rubocop)
- Uses [simplecov](https://github.com/colszowka/simplecov)
- Uses [i18n-tasks](https://github.com/glebm/i18n-tasks)

## Getting Started

### Start a new project

To start a new project with Muffi, simply create a new repository on GitHub
using this repository as a template.
(You loose the Muffi history, adding everything in Muffi at that time as a single initial commit)

Alternatively, import Muffi into a new repository by going to https://github.com/new/import and specify https://github.com/abtion/muffi.git
(You retain all the Muffi history)

####

Set up branch protection rules:

- Require status checks before merging (all except bundle-audit).
- Require branches to be up to date.
- Require signed commits.

### Replace license

Replace the contents of `LICENSE.md` with the following:

```
Copyright (C) Abtion - All Rights Reserved
Unauthorized copying of this project, via any medium is strictly prohibited.
Proprietary and confidential.
```

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

1. Create staging heroku app based on the muffi template.
   1. Visit: https://dashboard.heroku.com/new?org=abtion&template=https%3A%2F%2Fgithub.com%2Fabtion%2Fmuffi
   2. Fill in the name with `<PROJECT-NAME>-staging`.
   3. Select europe as region.
   4. Create a new pipeline for the project `<PROJECT-NAME>`.
   5. Fill in required env vars (read the field descriptions for guidance).
   6. Press the deploy button.
   7. Take a 5 minute break while heroku sets up app and pipeline.
   8. Sometimes the app will build, but it doesn't go on with the next steps and there is a not very informative error message. If so the app has likely been deployed, but not added to the pipeline. You will then have to manually create the pipeline and add the app to it.
2. Create the production app the same way as the staging app, only this time:
   - Name the app `<PROJECT-NAME>-production`.
   - Add the app the `<PROJECT-NAME>` pipeline rather than creating one.
3. Go to the pipeline "manage app" -> select the pipeline in the breadcrumb.
4. Connect the pipeline to the project's github repo. (There should be a "Connect to Github" button).
5. Enable review apps.
6. Add config vars for review apps:
   - `SEED_ADMIN_EMAIL`
   - `SEED_ADMIN_INITIAL_PASSWORD`
   - `HTTP_AUTH_USERNAME`
   - `HTTP_AUTH_PASSWORD`
   - `MAIL_FROM`

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
3. `HTTP_AUTH_USERNAME`
4. `HTTP_AUTH_PASSWORD`

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

[Unlicense](https://unlicense.org/)

## About Abtion

[![Abtion](abtion.png "Abtion")](https://abtion.com/)

[Abtion](https://abtion.com/) is a technology company building software and
services that make life better, easier and more fun. Zeros and ones are the
backbone of our work, and together with a diverse mix of designers, developers
and strategists, we create websites, mobile- and web applications with a purpose.
