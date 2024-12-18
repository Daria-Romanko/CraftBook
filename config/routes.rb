Rails.application.routes.draw do
  root "home#index"

  resources :projects
  resources :projects do
    member do
      get "delete", to: "projects#delete"
    end
  end
  resources :projects do
    resources :recipes do
      post "add_ingredient", on: :member
      post "add_tag", on: :member
    end
  end
  resources :projects do
    resources :ingredients, only: [ :index, :new, :create ]
    resources :recipes, only: [ :index, :new, :create, :show,  :edit, :destroy ]
    # resources :tags, only: [:index, :new, :create]
  end
  resource :session
  resources :passwords, param: :token
  resources :registrations, only: [ :new, :create ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
