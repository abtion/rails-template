# Abtion Rails Template

- [Abtion Rails Template](#abtion-rails-template)
  - [What is this?](#what-is-this)
    - [What are the benefits of using this?](#what-are-the-benefits-of-using-this)
    - [Finding the right compromise](#finding-the-right-compromise)
  - [Key features](#key-features)
  - [Getting Started](#getting-started)
    - [Start a new project](#start-a-new-project)
      - [Set up branch protection rules](#set-up-branch-protection-rules)
    - [Replace license](#replace-license)
    - [Configure the project](#configure-the-project)
    - [Setup colors](#setup-colors)
    - [Configure CD](#configure-cd)
    - [Configure i18n tasks](#configure-i18n-tasks)
    - [Setup mailing](#setup-mailing)
    - [Setup basic auth](#setup-basic-auth)
    - [Set up Dependabot](#set-up-dependabot)
    - [Set up database backups](#set-up-database-backups)
  - [Contributing](#contributing)
  - [License](#license)
  - [About Abtion](#about-abtion)

## What is this?

The Abtion Rails template - also known as **_Muffi on rails_** - is a project template maintained by [Abtion](https://abtion.com/) and used to kick start
Ruby on Rails applications.

### What are the benefits of using this?

- Much less time spent on "first-time setup":
  - Projects starting from this template include all the libraries we typically use at Abtion on the latest version.
  - Basic functionality is there from the start; we can have the app live from the moment we start, start sending emails, or log in with a user to the system.
- Lots of decisions are already made:
  - We've made these same decisions many times - now we know which decisions are the right ones.
- Fully functional test setup.
  - Tests are not an afterthought. They are an integrated part of the development flow.
  - Reliable software from day one.
- Easy for developers to switch between similar projects.
  - Easy to scale projects up and down. Developers know what to expect when they join the project. They've seen similar things before.
  - Less reliance on specific people - the whole team can contribute even when a team member is not present.

### Finding the right compromise

Everything in the template has been carefully considered in regards to:

- We want to be open to multiple unknown futures, with one single template.
- But we don't want the feature creep to creep up on us too much.

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

To start up, simply create a new repository on GitHub using this repository as a template.
(You lose the template's history, adding everything as one initial commit)

Alternatively, import the template into a new repository by going to https://github.com/new/import and specifying https://github.com/abtion/rails-template.git (You retain all template history)

#### Set up branch protection rules

- Require status checks before merging.
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

### Setup colors

`colors.json` must be updated so match the client's company colors/design guide.

If there's a designer on the project, get that person to fill in all the colors and nuances.

If there's no designer present, replace the colors with company colors where it makes sense. Use a tool like the following for creating nuances:
https://tailwind.simeongriggs.dev/

All the predefined colors are required for the built-in components to work:

- Contrast colors are picked from the "light" and "dark" colours.
- Contextual colors (primary, secondary, etc.) are used for component variants.

### Configure CD

1. Create staging heroku app based on the template.
   1. Visit: https://dashboard.heroku.com/new?org=abtion&template=https%3A%2F%2Fgithub.com%2Fabtion%2Frails-template
   2. Fill in the name with `<PROJECT-NAME>-staging`.
   3. Select europe as region.
   4. Create a new pipeline for the project `<PROJECT-NAME>`.
   5. Fill in required env vars (read the field descriptions for guidance).
   6. Press the deploy button.
   7. Take a 5 minute break while heroku sets up app and pipeline.
   8. Sometimes the app will build, but it doesn't go on with the next steps and there is a not very informative error message.
      - If so the app has likely been deployed, but not added to the pipeline. You will then have to manually create the pipeline and add the app to it.
2. Create the production app the same way as the staging app, only this time:
   - Name the app `<PROJECT-NAME>-production`.
   - Add the app to the `<PROJECT-NAME>` pipeline rather than creating one.
   - Add the app to the "production" stage of the pipeline
3. When app creation has succeeded, press "manage app" to get to the app, then select the pipeline in the breadcrumb
4. Connect the pipeline to the project's github repo. (There should be a "Connect to Github" button).
5. Enable review apps.
6. Add config vars for review apps:
   - `SEED_ADMIN_EMAIL`
   - `SEED_ADMIN_INITIAL_PASSWORD`
   - `HTTP_AUTH_USERNAME`
   - `HTTP_AUTH_PASSWORD`

### Configure i18n tasks

If you need to ignore specific translation keys, follow this process:

1. Open `config/i18n-tasks.yml`.
2. Go to `ignore_unused` or `ignore_missing` depending on whether you need to
   ignore unused translations, e.g., if a gem adds new translation keys, or
   missing translations.
3. Add your key(s) to the section in the YAML file.
4. See the configuration file for examples on more advanced usages.

### Setup mailing

Setting up email has historically proven to be something we cannot do in the beginning of projects. A project needs a domain, and we need access to the DNS settings of that domain. Furthermore there are clients running their own SMTP servers elsewhere.

For those reasons the template is set up to use [mailtrap](https://elements.heroku.com/addons/mailtrap) by default. Mailtrap catches any sent emails and allows us to potentially debug them. Most importantly it lets the app run without a hitch until the requirements for setting up real email are met.

When a project eventually gets a domain, and we have access to the domain's DNS settings, our goto solution is to set up [brevo](https://www.brevo.com/) for the production environment:

1. Remove the mailtrap addon on heroku
2. Register and add to 1Password new brevo account
   1. Register: https://app.brevo.com/account/register
   2. Email: Client google group account
   3. Password: Generate in 1Password
3. You must validate a phone number to start sending mails.
   1. Use Abtion's shared phone number 60 57 59 72 and check the code in #access-and-permissions (Slack)
4. Generate brevo keys
   1. Go to SMTP & API under user settings
   2. Click on SMTP Tab
   3. Create a new SMTP KEY.
   4. Copy smtp key value to `BREVO_PASSWORD` variable on clients heroku project
   5. Copy login to `BREVO_USERNAME` variable on clients heroku project
5. Setup DNS:
   1. Go to: https://account.brevo.com/senders
   2. Open "Domains"
   3. Add a new domain
   4. Fill in domain name and check the option to digitally sign emails, then continue
   5. Add each of the shown DNS records to the client's DNS setup.
      The DNS provider differs from client to client depending on whether we bought the domain or they did it themselves.
      If we don't have access, we provide the settings to the client so they can set it up.
   6. It will take an hour or so for new records to propagate, be patient.
   7. Back on the brevo page, validate each setting.
   8. When all settings are validated, the setup is complete.

### Setup basic auth

For added security we want to add basic auth to our review/staging environments.

1. Go to the Review/Staging app in the Heroku dashboard.
2. Add environment variables for:
3. `HTTP_AUTH_USERNAME`
4. `HTTP_AUTH_PASSWORD`

### Set up Dependabot

To allow Dependabot to auto-merge security updates, you need to add a secret
token to the settings of your project on GitHub. Follow these steps:

1. Acquire a token
   1. Sign into github using the client github account. (More info [here](https://inside.abtion.com/tools_and_services/access_and_permissions.html#github))
   2. Create an access token (classic with no expiration) (use [this](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-personal-access-token-classic) guide)
2. Set up the token
   1. Go to "Settings" > "Secrets" for the repository.
   2. Click "New secret".
   3. Set the name to `AUTO_MERGE_TOKEN` and insert the token.
   4. Click "Add secret".

### Set up database backups

To enable DB backups, see this guide: https://github.com/abtion/heroku-db-backup-s3

## Contributing

The Abtion Rails Template is maintained by [_Abtioneers_](#about-abtion), but open for anyone to suggest improvements and bugfixes.

One abtioneer is currently responsible for the project at Abtion, with support from other employees.

Please see [CONTRIBUTING.md](https://github.com/abtion/rails-template/blob/main/CONTRIBUTING.md).

## License

[Unlicense](https://unlicense.org/)

## About Abtion

[![Abtion](abtion.png "Abtion")](https://abtion.com/)

[Abtion](https://abtion.com/) is a technology company building software and
services that make life better, easier and more fun. Zeros and ones are the
backbone of our work, and together with a diverse mix of designers, developers
and strategists, we create websites, mobile- and web applications with a purpose.
