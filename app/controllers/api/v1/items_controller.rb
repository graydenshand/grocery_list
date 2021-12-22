# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      # GET /items
      ## accepts a `item_list_id` query parameter to filter for items belonging to a particular list
      def index
        @items = if params[:item_list_id]
                   Item.where(item_list_id: params[:item_list_id]).order(created_at: :desc)
                 else
                   Item.order(created_at: :desc)
                 end
        render json: @items, status: 200
      end

      # GET /items/:id
      def show
        @item = Item.find(params[:id])
        render json: @item, status: 200
      end

      # POST /items
      def create
        @item = Item.create! item_params
        render json: @item, status: 200
      end

      # PUT/PATCH /items/:id
      def update
        @item = Item.find(params[:id])
        @item.update! item_params
        render json: @item, status: 200
      end

      # DELETE /items/:id
      def destroy
        @item = Item.find(params[:id])
        @item.destroy!
        render json: { message: 'Item deleted' }, status: 200
      end

      private

      def item_params
        params.permit(:name, :description, :quantity, :id, :item_list_id)
      end
    end
  end
end
