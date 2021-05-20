source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.3.2'
gem 'react-rails'
gem 'sass-rails', '~> 5'
gem 'webpacker', '~> 4.0'

gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'redis', '~> 4.0'

gem 'bootstrap', '~> 4.2.1'
gem 'local_time'

gem 'cancancan'
gem 'devise'
gem 'devise_invitable'
gem 'rolify'

gem 'immutable-struct'

gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sinatra', require: nil

gem 'gravatar_image_tag'

gem 'money-rails'

gem 'slack-notifier'

gem 'bootstrap-email'
gem 'cocoon'

gem 'stripe'
gem 'stripe_event'

gem 'github_api'
gem 'omniauth-github'

gem 'mixpanel-ruby'

gem 'lol_dba'
gem 'rack-mini-profiler'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bullet'
  gem 'byebug', platforms: [:mri]
  gem 'capybara'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails', github: 'rspec/rspec-rails', branch: '4-0-dev'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false, group: :test
  gem 'webdrivers', '~> 4'
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'foreman'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'rack-cors', require: 'rack/cors'
