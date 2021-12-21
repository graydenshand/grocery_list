# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      # GET /items
      def index
        @items = Item.order(created_at: :desc)
        render json: @items, status: 200
      end

      # GET /items/:id
      def show
        @item = Item.find(params[:id])
        render json: @item
      end

      # POST /items
      def create
        Item.transaction do
          @item = Item.new(item_params)
          @event = Event.new(action: 'create_item', item: params[:name])
          @item.save!
          @event.save!
        end
        render json: @item, status: 200
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: 'Unable to create item' }, status: 400
      end

      # PUT /items/:id
      def update
        Item.transaction do
          @item = Item.find(params[:id])
          if @item
            @item.update(item_params)
            new_qty = params[:quantity].to_i
            if new_qty > @item.quantity
              # Increment
              @event = Event.new(action: 'increment_item', item: @item.name)
            else
              # Decrement
              @event = Event.new(action: 'decrement_item', item: @item.name)
              @event.save!
            end
            render json: @item, status: 200
          else
            render json: { error: 'Not found' }, status: 404
          end
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: 'Unable to update item' }, status: 400
      end

      # DELETE /items/:id
      def destroy
        @item = Item.find(params[:id])
        if @item
          Item.transaction do
            @event = Event.new(action: 'delete_item', item: @item.name)
            @event.save!
            @item.destroy
            render json: { message: 'Item deleted' }, status: 200
          end
        else
          render json: { error: 'Not found' }, status: 404
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: 'Unable to delete item' }, status: 400
      end

      private

      def item_params
        params.permit(:name, :description, :quantity, :id)
      end
    end
  end
end
