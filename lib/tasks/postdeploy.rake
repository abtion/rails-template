# frozen_string_literal: true

desc "Review Apps Post-Deploy"

namespace :postdeploy do
  DUMP_STAGING_DATABASE = "pg_dump -cOx $STAGING_DATABASE_URL"
  LOAD_DATA = "psql $DATABASE_URL"
  MIGRATE_AND_SEED = "bundle exec rails db:migrate db:seed"

  task :postdeploy do
    if review_app?
      shell_command = "#{DUMP_STAGING_DATABASE} | #{LOAD_DATA} && #{MIGRATE_AND_SEED}"
      system(shell_command)
    end
  end
end

def review_app?
  ENV["HEROKU_APP_NAME"] =~ /pr-[1-9]/
end
