require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase 
  test "full title helper" do
    assert_equal full_title, 'Random Thoughts'
    assert_equal full_title('Help'), 'Help | Random Thoughts'
  end
end