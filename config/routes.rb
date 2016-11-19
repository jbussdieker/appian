Rails.application.routes.draw do
  resources :deployments

  resources :projects

  resources :providers

  root :to => 'home#index'
end
