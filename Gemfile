source 'http://rubygems.org'

gem 'rails', '3.0.10'
gem 'nokogiri'
gem 'mongoid', '2.1.2'
gem 'haml'
gem 'will_paginate', '>=3'
gem 'htmlentities', "~> 4.3.0"
gem 'devise', '~> 1.4.0'
gem 'lighthouse-api'
gem 'redmine_client', :git => "git://github.com/oruen/redmine_client.git"
gem 'mongoid_rails_migrations'
gem 'useragent', '~> 0.3.1'
gem 'pivotal-tracker'
gem 'ruby-fogbugz', :require => 'fogbugz'
gem 'octokit'
gem 'inherited_resources'
gem 'SystemTimer', :platform => :ruby_18
gem 'hoptoad_notifier', "~> 2.4"
gem 'actionmailer_inline_css', "~> 1.2.0"

platform :ruby do
  gem 'bson_ext', '~> 1.3.1'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.5'
  gem 'webmock', :require => false
  gem 'capistrano'
  gem 'factory_girl_rails'
  unless ENV['TRAVIS']
    gem 'ruby-debug', :platform => :mri_18
    gem 'ruby-debug19', :platform => :mri_19, :require => 'ruby-debug'
  end
end

group :test do
  gem 'rspec', '~> 2.5'
  gem 'database_cleaner', '~> 0.6.0'
  gem 'email_spec'
end

group :heroku do
  gem 'thin'
end

