# frozen_string_literal: true

Rails.application.routes.draw do
  resources :exchange_rates, only: :index

  root 'exchange_rates#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
