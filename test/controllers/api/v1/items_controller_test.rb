# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ItemsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @list = item_lists(:grocery)
        @item = items(:one)
      end

      test 'should get index' do
        get api_v1_items_url
        assert_response :success
        assert_equal((JSON.parse @response.body).length, 3)
      end

      test 'should filter by list_item_id' do
        get api_v1_items_url, params: { item_list_id: @list.id }
        assert_response :success
        assert_equal((JSON.parse @response.body).length, 2)
      end

      test 'should create item' do
        # Test that an event is created when an item is created
        assert_difference('Event.count') do
          # Test that the item is created
          assert_difference('Item.count') do
            post api_v1_items_url, params: { name: 'test item', quantity: 1, item_list_id: @list.id }
          end
        end

        assert_response :success
      end

      test 'should show item' do
        get api_v1_item_url(@item)
        assert_response :success
      end

      test 'should update item' do
        # Test that an event is created when an item is updated
        assert_difference('Event.count') do
          # Test that the item is updated
          patch api_v1_item_url(@item), params: { name: 'test item', quantity: 2 }
          assert_response :success
        end
      end

      test 'should update item name' do
        assert_difference('Event.count') do
          # Test that the item is updated
          put api_v1_item_url(@item), params: { name: 'test item' }
          assert_response :success
        end
      end

      test 'should destroy item' do
        # Test that an event is created when an item is destroyed
        assert_difference('Event.count') do
          # Test that the item is destroyed
          assert_difference('Item.count', -1) do
            delete api_v1_item_url(@item)
          end
        end

        assert_response :success
      end
    end
  end
end
