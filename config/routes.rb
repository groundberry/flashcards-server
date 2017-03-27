Rails.application.routes.draw do
  get '/auth/github', to: 'authentication#github', format: false

  resource :user, only: [:show]

  resources :flashcards do
    get :tags, on: :member
  end

  resources :tags do
    get :flashcards, on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
