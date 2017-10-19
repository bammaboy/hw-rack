require 'test/unit/context'
require './app/models/email'

module EmailCollector
  DATABASE = './db/test.txt'
end

class EmailTest < Test::Unit::TestCase
  teardown do
    File.delete(EmailCollector::DATABASE) if File.exist?(EmailCollector::DATABASE)
  end

  test 'instance has errors getter' do
    assert_respond_to EmailCollector::Email.new(''), :errors
  end

  test 'instance has not errors setter' do
    assert_not_respond_to EmailCollector::Email.new(''), :errors=
  end

  test 'contructor required 1 argument' do
    assert_equal 1, EmailCollector::Email.instance_method(:initialize).arity
  end

  test 'instant responds to method save' do
    assert_respond_to EmailCollector::Email.new(''), :save
  end

  context 'call method #save' do
    context 'on email with wrong address' do
      setup do
        @email = EmailCollector::Email.new('')
      end

      test 'return false' do
        assert_false @email.save
      end

      test 'set errors message' do
        @email.save
        assert_equal 'Wrong email format.', @email.errors
      end

      test 'not writing in db' do
        assert_raise do
          File.open(EmailCollector::DATABASE, &:readline)&.chomp
        end
      end
    end

    context 'on email with correct address' do
      setup do
        @address = 'email@example.com'
        @email = EmailCollector::Email.new(@address)
      end

      test 'return true' do
        assert @email.save
      end

      test 'not set any error messages' do
        @email.save
        assert_equal '', @email.errors
      end

      test 'writes email address to db' do
        @email.save
        assert_equal @address, File.open(EmailCollector::DATABASE, &:readline)&.chomp
      end
    end
  end
end
