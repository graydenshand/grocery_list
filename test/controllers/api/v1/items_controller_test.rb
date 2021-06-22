require "test_helper"

class Api::V1::ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get api_v1_items_url
    assert_response :success
  end

  test "should create item" do
    # Test that an event is created when an item is created
    assert_difference("Event.count") do
      # Test that the item is created
      assert_difference('Item.count') do
        post api_v1_items_url, params: { name: "test item", quantity: 1 }
      end
    end

    assert_response :success
  end

  test "should show item" do
    get api_v1_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    # Test that an event is created when an item is updated
    assert_difference("Event.count") do
      # Test that the item is updated
      patch api_v1_item_url(@item), params: { name: "test item", quantity: 2 }
      assert_response :success
    end
  end

  test "should destroy sitem" do
    # Test that an event is created when an item is destroyed
    assert_difference("Event.count") do
      # Test that the item is destroyed
      assert_difference('Item.count', -1) do
        delete api_v1_item_url(@item)
      end
    end

    assert_response :success
  end
end
