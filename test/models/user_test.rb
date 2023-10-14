require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(first_name: 'Valid', last_name: 'User', email: "valid@validity.valid")
  end 

  test "should be valid" do 
    assert @user.valid?
  end 

  test "name should be present" do 
    @user.first_name = "  "
    assert_not @user.valid?
  end 

  test "email should be present" do 
    @user.email = ""
    assert_not @user.valid?
  end 

  test "name should not be too long" do 
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do 
    @user.email =  "a" * 244 + "@example.com"
    assert_not @user.valid?
  end 

  test "emails validation should accept valid addresses" do 
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do | valid_address |
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do 
  invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com meeeeee]
  invalid_addresses.each do | invalid_address | 
    @user.email = invalid_address
    assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  end 
end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPLe.CoM"
    @user.email = mixed_case_email
    @user.save 
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # TESTS FOR FAVORITES # 
  test "should follow and unfollow a user" do
    matt = users(:matt)
    rose  = cultivars(:rose)
    assert_not matt.favorited?(rose)
    matt.favorite(rose)
    assert matt.favorited?(rose)
    matt.unfavorite(rose)
    assert_not matt.favorited?(rose)
  end
end
