# frozen_string_literal: true

module Api
  module V1
    class ItemListsController < ApplicationController
      # GET
      def index
        @lists = ItemList.all.order(:created_at)
        render json: @lists, status: 200
      end

      def show
        @list = ItemList.find(params[:id])
        resp = {
          list: @list,
          items: @list.items.all.order(:created_at)
        }
        render json: resp, status: 200
      end

      # POST
      def create
        params.require(:name)
        @list = ItemList.create!(params)
        render json: @list, status: 200
      end

      # PUT
      def update
        @list = ItemList.find(params[:id])
        @list.update! params.permit(:name)
        render json: @list, status: 200
      end

      # DELETE
      def destroy
        @list = ItemList.find(params[:id])
        @list.destroy!
        render json: { message: 'List deleted' }, status: 200
      end

    end
  end
end
