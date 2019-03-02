Rails.application.routes.draw do
  root "tests#index"

  get :signup, to: 'users#new'
  resources :users, only: :create

  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  post :logout, to: 'sessions#destroy'

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end
end
