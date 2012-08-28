source 'http://rubygems.org'

if RUBY_VERSION < '1.9'
  gem 'ruby-debug'
else
  gem 'debugger'
end

gem 'rspec-rails', '~> 2.11.0', group: [:development, :test]
group :test do
  # gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '~> 0.8.0'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem "shoulda-matchers", '~> 1.2.0'
end

gemspec
