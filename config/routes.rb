Rails.application.routes.draw do
  resources :contactform, only: [:create,:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  #post '/send_email' 'contactform#create' 
  get '/login', to: 'login#index'
  get '/signup', to: 'signup#index'
end
