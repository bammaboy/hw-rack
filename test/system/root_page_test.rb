require 'test/unit/context'
require 'test/unit/capybara'
require './app/application'

module EmailCollector
  DATABASE = './db/test.txt'.freeze
end

class RootPageTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = EmailCollector::Application
  end

  teardown do
    File.delete(EmailCollector::DATABASE) if File.exist?(EmailCollector::DATABASE)
  end

  context 'when visiting root path' do
    setup do
      visit '/'
    end

    test 'server responds with 200 status code' do
      assert_equal 200, page.status_code
    end

    test 'i should see correct title' do
      within 'h1' do
        assert_text 'Subscribe and be the first to know!'
      end
    end

    test 'i should see form with input and submit button' do
      within 'form' do
        assert_selector 'input[name="email"][type="text"]'
        within 'button[type="submit"]' do
          assert_equal 'Submit', text
        end
      end
    end

    test 'form action should eq emails' do
      assert_selector 'form[action="emails"]'
    end

    test 'form method should eq post' do
      assert_selector 'form[method="post"]'
    end
  end
end
