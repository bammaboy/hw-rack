require 'test/unit/context'
require 'test/unit/capybara'
require './app/application'

class NotFoundTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = EmailCollector::Application
  end

  context 'when visiting not used url' do
    setup do
      visit 'not_found'
    end

    test 'server responds with 404 status code' do
      assert_equal 404, page.status_code
    end

    test 'i should see error message' do
      assert_text 'Not found'
    end
  end
end
