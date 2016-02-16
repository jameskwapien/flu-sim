Rails.application.routes.draw do
 
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :groups, :main
  
  resources :posts do
    resources :comments
  end

  resources :memberships
 
  resources :groups

  root "main#index"
 
end
