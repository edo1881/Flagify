require "test_helper"

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:one)
    # @challenge = challenges(:one)
  end

  test "should get index" do 
    get new_user_session_path
    assert_response :success
  end

  test "should log in" do
    post user_session_path, params:{email: @user.email, encrypted_password: @user.encrypted_password}
    assert_response :success
  end

end
