Rails.application.routes.draw do
  resources :users do
    resources :flashcards do
      get :tags, on: :member
    end
    resources :tags do
      get :flashcards, on: :member
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
