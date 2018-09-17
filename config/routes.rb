Rails.application.routes.draw do
  resources :exchange_rates
  resources :date_to
  resources :date_from
  

  root 'exchange_rates#index'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
