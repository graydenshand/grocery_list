# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ItemListsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @list = item_lists(:grocery)
      end

      test 'should get index' do
        get api_v1_item_lists_url
        assert_response :success
        assert (JSON.parse @response.body).length == 2
      end

      test 'should show items' do
        get api_v1_item_list_url(@list)
        assert_response :success
        assert_not_nil (JSON.parse @response.body)['list']
        assert_not_nil (JSON.parse @response.body)['items']
      end

      test 'should create item_list' do
        # Test that an event is created when an item is created
        assert_difference('Event.count') do
          # Test that the item is created
          assert_difference('ItemList.count') do
            post api_v1_item_lists_url, params: { name: 'test item list' }
          end
        end
        assert_response :success
      end

      test 'should update item' do
        # Test that an event is created when an item is updated
        assert_difference('Event.count') do
          # Test that the item is updated
          patch api_v1_item_list_url(@list), params: { name: 'test list' }
          assert_response :success
          assert_equal 'test list', (JSON.parse @response.body)['name']
        end
      end

      test 'should destroy items' do
        # Test that 3 events are created when list is destroyed
        ## a 'delete_item' event for the two items in the list
        ## a 'delete_list' event for the list itself
        assert_difference('Event.count', 3) do
          # Test that the item is destroyed
          assert_difference('ItemList.count', -1) do
            delete api_v1_item_list_url(@list)
          end
        end
        assert_response :success
      end
    end
  end
end
