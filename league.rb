system 'rm Gemfile' if File.exist?('Gemfile')
File.write('Gemfile', <<-GEMFILE)
  source 'https://rubygems.org'

  gem 'activerecord'
  gem 'sqlite3'
  gem 'pg'

  gem 'minitest-reporters'
  gem 'database_cleaner'
GEMFILE

system 'bundle install'

require 'bundler'
Bundler.setup(:default)

require 'logger'

require 'active_record'
require 'active_support/all'
require 'active_model'

%w(
  db/schema.rb
  models/*.rb
  specs/support/*.rb
  specs/*.rb
).each do |path|
  location = File.expand_path(path, __dir__)
  Dir[location].each { |f| require f }
end
