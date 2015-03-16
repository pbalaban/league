require 'minitest/autorun'
require "minitest/reporters"
require 'database_cleaner'

Minitest::Reporters.use!
DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
