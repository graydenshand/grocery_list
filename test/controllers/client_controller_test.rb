require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_index_url
    assert_response :success
  end
end
