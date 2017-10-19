require 'test/unit/context'
require 'test/unit/capybara'
require './app/application'

module EmailCollector
  DATABASE = './db/test.txt'
end

class EmailsTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = EmailCollector::Application
  end

  teardown do
    File.delete(EmailCollector::DATABASE) if File.exist?(EmailCollector::DATABASE)
  end

  context 'when i on root page' do
    setup do
      visit '/'
    end

    context 'and submitting correct email' do
      setup do
        @email = 'email@example.com'

        fill_in 'email', with: @email

        click_button 'Submit'
      end

      test 'server responds with 201 status code' do
        assert_equal 201, page.status_code
      end

      test 'i should see success message' do
        assert_text 'You successfully subscribed!'
      end

      test 'email saved to db' do
        assert_equal @email, File.open(EmailCollector::DATABASE, &:readline)&.chomp
      end
    end

    context 'and submitting wrong email' do
      setup do
        @email = 'email@'

        fill_in 'email', with: @email

        click_button 'Submit'
      end

      test 'server responds with 422 status code' do
        assert_equal 422, page.status_code
      end

      test 'i should see error message' do
        assert_text 'Errors: Wrong email format.'
      end

      test 'email not saved to db' do
        assert_raise do
          File.open(EmailCollector::DATABASE, &:readline)&.chomp
        end
      end
    end

    context 'and submitting form without params' do
      setup do
        find('input[name="email"][type="text"]').native.remove
        click_button 'Submit'
      end

      test 'server responds with 403 status code' do
        assert_equal 403, page.status_code
      end

      test 'i should see error message' do
        assert_text 'Missing param: email'
      end

      test 'email not saved to db' do
        assert_raise do
          File.open(EmailCollector::DATABASE, &:readline)&.chomp
        end
      end
    end
  end
end
