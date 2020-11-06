# frozen_string_literal: true

require 'test_helper'

class DeviseMailerTest < ActionMailer::TestCase
  test 'confirmation_instructions' do
    mail = DeviseMailer.confirmation_instructions
    assert_equal 'Confirmation instructions', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
