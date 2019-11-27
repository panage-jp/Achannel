Rails.application.routes.draw do
  root to: "rooms#index"
  resources :messages
  get "rooms/serch" => "rooms#search"
  resources :rooms
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
