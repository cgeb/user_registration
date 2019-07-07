Rails.application.routes.draw do
  get 'login', to: "sessions#new", as: "login"
  post 'sessions/create'
  delete 'logout', to: 'sessions#destroy', as: "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update], param: :token
end
