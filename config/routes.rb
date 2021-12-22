# frozen_string_literal: true

Rails.application.routes.draw do
  # get "client/index"

  namespace :api do
    namespace :v1 do
      resources :items, :item_lists
    end
  end

  get '/*path', to: 'client#index'
  root 'client#index'
end
