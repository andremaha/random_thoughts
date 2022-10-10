require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new name: "Example User", 
                     email: "me@example.com",
                     password: "asdf1234rewq",
                     password_confirmation: "asdf1234rewq"
  end

  test "initial user should be valid" do 
    assert @user.valid?
  end 

  test "name should be present" do 
    @user.name = "       "
    assert_not @user.valid?
  end 

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do 
    @user.name = "b" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do 
    @user.email = "b" * 255 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do 
    valid_addresses = %w[user@example.com 
                         USER@foo.COM 
                         A_US-ER@foo.bar.org 
                         first.last@foo.jp 
                         alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test "email validation should reject invalid email addresses" do 
    invalid_addresses = %w[user@example,com
                           boozer_at_foo.com
                           user.name@example
                           foo@bar_baz.com
                           foo@bar+baz.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be invalid"
    end
  end

  test "email address should be unique" do 
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved in downcase" do 
    mixed_email = "uSER@foo.COM"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end

  test "password should be present (non-blank)" do 
    @user.password = @user.password_confirmation = "   " * 6
    assert_not @user.valid?
  end

  test "password should be at least 6 chars long" do 
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
