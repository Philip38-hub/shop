## Running shop for the first time
- bundle install - try gem install bundler
- export PATH="$PATH:/home/bigman/.gem/ruby/3.3.0/bin" && bundle install //add gem executables directory to path
- bin/rails -v //run rails from the app
- /home/bigman/.gem/ruby/3.3.0/bin/bundle install //try to use the full path to the bundler executable
- rm Gemfile.lock && /home/bigman/.gem/ruby/3.3.0/bin/bundle install // remove gem.lock
- /home/bigman/.gem/ruby/3.3.0/bin/bundle install --path vendor/bundle install gem locally with the path option
- BUNDLE_PATH=vendor/bundle bundle exec rails db:setup // try setting up db
- find vendor/bundle -name rails -type f | grep bin/rails // find the rails executable
- vendor/bundle/ruby/3.3.0/bin/rails db:setup // use the rays executable directly
- vendor/bundle/ruby/3.3.0/bin/rails db:setup // try the rails executables
- vendor/bundle/ruby/3.0.0/bin/rails db:setup
- (add loger to logger_thread_safe_level.rb)
- rails db:setup
- rails db:migrate
- rails db:seed
- rails s/server

