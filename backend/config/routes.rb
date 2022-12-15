# frozen_string_literal: true

Rails.application.routes.draw do
  post :user_token, controller: :user_token, action: :create

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index]
    end
  end
end
