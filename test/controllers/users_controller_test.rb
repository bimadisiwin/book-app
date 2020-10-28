require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get ahow" do
    get users_ahow_url
    assert_response :success
  end

end
