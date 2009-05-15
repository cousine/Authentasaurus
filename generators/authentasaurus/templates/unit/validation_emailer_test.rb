require 'test_helper'

class ValidationEmailerTest < ActionMailer::TestCase
  test "validation_mail" do
    @expected.subject = 'ValidationEmailer#validation_mail'
    @expected.body    = read_fixture('validation_mail')
    @expected.date    = Time.now

    assert_equal @expected.encoded, ValidationEmailer.create_validation_mail(@expected.date).encoded
  end

end
