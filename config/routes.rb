Rails.application.routes.draw do
  root "home#index"

  resources :projects

  resources :projects do
    member do
      get "delete", to: "projects#delete"
    end

    resources :recipes do
      member do
      get "delete", to: "recipes#delete"
      post "add_ingredient"
      post "add_tag"
      delete "remove_ingredient/:ingredient_recipe_id", to: "recipes#remove_ingredient", as: :remove_ingredient
      delete "remove_tag/:recipe_tag_id", to: "recipes#remove_tag", as: :remove_tag
      end
    end

    resources :ingredients do
      member do
      get "delete", to: "ingredients#delete"
      end
    end

    resources :recipes, only: [ :index, :new, :create, :show,  :edit, :destroy ]

    resources :tags do
      member do
      get "delete", to: "tags#delete"
      end
    end
  end

  resource :session
  resources :passwords, param: :token
  resources :registrations, only: [ :new, :create ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
