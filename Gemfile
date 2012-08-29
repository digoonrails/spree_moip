source 'http://rubygems.org'

if RUBY_VERSION < '1.9'
  gem 'ruby-debug'
else
  gem 'debugger'
end

group :assets do
  gem 'sass-rails', "~> 3.2"
  gem 'coffee-rails', "~> 3.2"
end

group :development, :test do
  gem 'rspec-rails', '~> 2.11.0'
  gem 'ephemeral_response'
end

group :test do
  # gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '~> 0.8.0'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem "shoulda-matchers", '~> 1.2.0'
  gem 'launchy'
end

gemspec
