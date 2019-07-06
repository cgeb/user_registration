Rails.application.routes.draw do
  get 'sessions/new', as: "login"
  post 'sessions/create'
  get 'sessions/destroy', as: "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
end
