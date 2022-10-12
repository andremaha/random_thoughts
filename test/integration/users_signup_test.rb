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

  test "sucessful form submission" do
    get signup_path
    assert_difference 'User.count' do 
      post users_path, params: { user: { name: "Valid User",
                                         email: "valid@example.com",
                                         password: "asdffdsa",
                                         password_confirmation: "asdffdsa" }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select '.alert-success', 'User profile created successfully!'
    assert flash[:success]
    assert_not flash[:error]
    assert_not flash.empty?
  end
end
