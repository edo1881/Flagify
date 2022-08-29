Rails.application.routes.draw do
  devise_for :users,controllers: {omniauth_callbacks: "users/omniauth_callbacks" }
  resources :contactform, only: [:create,:new]
  resources :challenges,only: [:new,:index,:update,:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  #post '/send_email' 'contactform#create' 
  get '/challenges', to: 'challenges#index'
  get '/scoreboard', to: 'scoreboard#index'
  get '/profile', to: 'profile#index'
  
end
