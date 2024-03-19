Rails.application.routes.draw do
  # resources :answers
  root 'tests#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :test_attempts, only: %i[show update] do
    member do
      get :result
    end
  end
end
