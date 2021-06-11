class Api::V1::ItemsController < ApplicationController

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
		@item = Item.new(item_params)
		if @item.save
			render json: @item, status: 200
		else
			render error: { error: 'Unable to create item' }, status: 400
		end
	end

	# PUT /items/:id
	def update
		@item = Item.find(params[:id])
		if @item
			@item.update(item_params)
			render json: @item, status: 200
		else
			render json: { error: "Not found"}, status: 404
		end
	end

	# DELETE /items/:id
	def destroy
		@item = Item.find(params[:id])
		if @item
			@item.destroy
			render json: { message: "Item deleted"}, status: 200
		else
			render json: { error: "Not found" }, status: 404
		end
	end

	private

	def item_params
		params.permit(:name, :description, :quantity, :id)
	end

end
