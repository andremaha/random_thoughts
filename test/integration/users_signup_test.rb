require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "unsuccessful form submission" do 
    get signup_path
    assert_no_difference 'User.count' do 
      post users_path, params: { user: { name: " ",
                                         email: "invalid@example,com",
                                         password: "asdf",
                                         password_confirmation: "fdsa" }}
    end
    assert_template 'users/new'
    assert_select '#error_explanation'
    assert_select '#error_explanation ul li', "Name can't be blank"
    assert_select '#error_explanation ul li', "Password is too short (minimum is 6 characters)"
    assert_select '#error_explanation ul li', "Password confirmation doesn't match Password"
  end
end
