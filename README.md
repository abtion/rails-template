[![Maintainability](https://api.codeclimate.com/v1/badges/d0e13853fa82d32e650a/maintainability)](https://codeclimate.com/repos/5dcbb7cd09f28e014c00f396/maintainability)

# Muffi

1. [Muffi](#muffi)
   1. [What is Muffi?](#what-is-muffi)
   2. [Key features](#key-features)
   3. [Getting Started](#getting-started)
      1. [Start a new project](#start-a-new-project)
      2. [Configure the project](#configure-the-project)
      3. [Configure Code Climate](#configure-code-climate)
      4. [Configure CD](#configure-cd)
      5. [Capybara drivers](#capybara-drivers)
   4. [Contributing](#contributing)
   5. [License](#license)
   6. [About Abtion](#about-abtion)

## What is Muffi?

Muffi is a project template maintained by [Abtion](https://abtion.com/) and used to kick start
Ruby on Rails applications.

## Key features

* Heroku ready - Review apps, staging and production
* Uses [devise](https://github.com/plataformatec/devise)
* Uses [Heroku CI](https://heroku.com)
* Uses [rspec](https://github.com/rspec/rspec-rails)
* Uses [simplecov](https://github.com/colszowka/simplecov)
* Uses [rubocop](https://github.com/bbatsov/rubocop)

## Getting Started

### Start a new project

To start a new project with Muffi, simply create a new repository on GitHub
using this repository as a template.

Alternatively, clone this repository and change the git remote to point to
your own repository.

### Configure the project

1. Edit `application.rb` and change the module name and configuration settings.
2. Edit the database names in `database.yml`
3. Use "search and replace" to replace project specific strings across all files:
   - PROJECT_DOMAIN => project-name.com
   - PROJECT_NAME_PARAM => project-name
   - PROJECT_NAME_PASCAL => ProjectName
   - PROJECT_NAME_SNAKE => project_name
   - PROJECT_NAME_HUMAN => Project name

   Note: The application name is wrapped around comments used to disable a rubocop check.
   When the application has been renamed, the comments should be removed.
   (See config/application.rb#L25-27)
4. `cp .env.example .env`
5. `cp .env.development.example .env.development`
6. `cp .env.test.example .env.test`
7. `mv README.example.md README.md`
8. Add `export DATABASE_URL="postgresql://HOST:@localhost:5432"` to .env.development and .env.test

### Configure Code Climate

1. Login to CodeClimate and add your project
2. Go to `https://codeclimate.com/repos/<your-project>/settings/test_reporter`
3. Set up a Heroku pipeline.  
4. `heroku config:set CC_TEST_REPORTER_ID=<Code Climate test reporter ID>` 
5. Update https://codeclimate.com/repos/REPO_ID/settings/test_reporter to be at 100% diff coverage

### Configure CD

1. Log in to the [Heroku dashboard](https://dashboard.heroku.com)
2. Create a Pipeline, and two new applications
    - Staging: `<PROJECT-NAME>-staging`
    - Production: `<PROJECT-NAME>-production`
3. Turn on "Review Apps" from the Pipeline's page

### Capybara drivers

This project registers two Capybara drivers.

Set the environment variable `CAPYBARA_DRIVER` to `headless_chrome` (default) to run specs without
opening Chrome, or use `chrome` to open the browser automatically.

## Contributing

Muffi is maintained by [_Abtioneers_](#about-abtion), but open for anyone to suggest improvements and bugfixes.

One abtioneer is currently responsible for the project at Abtion, with support from other employees.

Please see [CONTRIBUTING.md](https://github.com/abtion/muffi/blob/master/CONTRIBUTING.md).

## License

[MIT](https://opensource.org/licenses/MIT)

## About Abtion

[![Abtion](abtion.png "Abtion")](https://abtion.com/)

[Abtion](https://abtion.com/) is a technology company building software and
services that make life better, easier and more fun. Zeros and ones are the
backbone of our work, and together with a diverse mix of designers, developers
and strategists, we create websites, mobile- and web applications with a purpose.
