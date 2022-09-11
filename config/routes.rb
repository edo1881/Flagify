Rails.application.routes.draw do
  devise_for :users,controllers: {omniauth_callbacks: "users/omniauth_callbacks" }
  resources :contactform, only: [:create,:new]
  resources :challenges
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/challenges/:id/delete', to: 'challenges#destroy'
  get '/users/become_player', to: 'users#become_player'
  post '/send_email',to: 'contactform#create' 
  get '/scoreboard', to: 'scoreboard#index'
 # get '/profile', to: 'profile#index'
  post '/challenges/check_flag', to: 'challenges#check_flag'
  get '/challenges/show_hint/:id', to: 'challenges#show_hint'
  
end
