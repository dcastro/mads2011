require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "project_deleted" do
    mail = Notifier.project_deleted
    assert_equal "Project deleted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
