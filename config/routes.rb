Rails.application.routes.draw do
  root to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'

  resources :users, only: %i(index show create edit update destroy)

  namespace :admin do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :users, only: %i(index destroy)
    resources :questions, only: %i(index destroy)
  end

  resources :questions do
    resources :answers, only: %i(create)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #letter_opener_web
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
