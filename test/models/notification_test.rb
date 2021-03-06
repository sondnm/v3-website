require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test "read, unread, read? and read!" do
    freeze_time do
      user = create :user
      notification = create :notification, user: user
      refute notification.read?
      assert_equal [], user.notifications.read
      assert_equal [notification], user.notifications.unread

      notification.read!
      assert notification.read?
      assert_equal Time.current, notification.read_at
      assert_equal [notification], user.notifications.read
      assert_equal [], user.notifications.unread
    end
  end
end
