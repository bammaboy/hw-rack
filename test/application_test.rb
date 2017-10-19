require 'test/unit/context'
require './app/application'

class ApplicationTest < Test::Unit::TestCase
  test 'defined constant DATABASE' do
    assert EmailCollector.const_defined?('DATABASE')
  end
end
