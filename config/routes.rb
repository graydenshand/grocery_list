# frozen_string_literal: true

Rails.application.routes.draw do
  get 'client/index'
  root 'client#index'

  namespace :api do
    namespace :v1 do
      resources :items
    end
  end
end
