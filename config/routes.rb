Rails.application.routes.draw do
  root "home#index"

  resources :projects

  resource :session
  resources :passwords, param: :token
  resources :registrations, only: [ :new, :create ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
