# frozen_string_literal: true

class ItemList < ApplicationRecord
  validates :name, presence: true
  has_many :items

  def self.create!(params)
    list = nil
    ItemList.transaction do
      list = ItemList.new(name: params[:name])
      list.save!
      event = Event.new(action: 'create_list', data: { list: list.name }.to_json)
      event.save!
    end
    list
  end

  def update!(params)
    ItemList.transaction do
      old = name
      name = params[:name]
      update(params)
      event = Event.new(action: 'rename_list', data: { old: old, new: name }.to_json)
      event.save!
    end
  end

  def destroy!
    ItemList.transaction do
      # call destroy! on items in list to support "undoing" this operation
      items.each(&:destroy!)
      destroy
      event = Event.new(action: 'destroy_list', data: { list: name }.to_json)
      event.save!
    end
  end
end
