Rails.application.routes.draw do
 
  resources :simulations
  get 'simulation/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :groups, :main
  
  resources :posts do
    resources :comments
  end

  resources :memberships
 
  resources :groups

  resources :simulations do
    put :java_test_2
  end

  root "main#index"
 
end
