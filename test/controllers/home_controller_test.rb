require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:one)
  end

  test "should get index" do 
    get root_path
    assert_response :success
  end
end
