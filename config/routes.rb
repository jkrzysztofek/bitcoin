Rails.application.routes.draw do
  root 'exchange_rates#index'
  get 'exchange_rates/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
