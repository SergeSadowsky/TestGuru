Rails.application.routes.draw do
  # get 'tests/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tests do
    resources :questions, shallow: true
  end
end
