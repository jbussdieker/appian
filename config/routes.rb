Rails.application.routes.draw do
  resources :providers

  root :to => 'home#index'
end
