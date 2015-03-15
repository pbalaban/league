system 'rm Gemfile' if File.exist?('Gemfile')
File.write('Gemfile', <<-GEMFILE)
  source 'https://rubygems.org'

GEMFILE

system 'bundle install'

require 'bundler'
Bundler.setup(:default)

require 'minitest/autorun'
require 'logger'

%w(
  models/*.rb
  specs/*.rb
).each do |path|
  location = File.expand_path(path, __dir__)
  Dir[location].each { |f| require f }
end
