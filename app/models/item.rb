# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :item_list

  def self.create!(item_params)
    item = nil
    Item.transaction do
      item = Item.new(item_params)
      event = Event.new(action: 'create_item', data: { item: item.name, list: item.item_list.name }.to_json)
      item.save!
      event.save!
    end
    item
  end

  def update!(item_params)
    Item.transaction do
      if item_params.include?(:quantity)
        new_qty = item_params[:quantity].to_i
        action = new_qty > quantity ? 'increment_item' : 'decrement_item'
        data = { item: name, list: item_list.name }.to_json
      else
        action = 'rename_item'
        data = { old: name, new: item_params[:name], list: item_list.name }.to_json
      end
      update(item_params)
      event = Event.new(action: action, data: data)
      event.save!
    end
  end

  def destroy!
    Item.transaction do
      @event = Event.new(action: 'delete_item', data: { item: name, list: item_list.name }.to_json)
      @event.save!
      destroy
    end
  end
end
