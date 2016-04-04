Rails.application.routes.draw do

  # for java simulation call
  get 'simulation/show'
  get 'welcome/index'
  # resources
  resources :groups
  resources :memberships
  resources :enrollments
  resources :courses
  resources :outputs
  resources :inputs
  resources :simulations do
    put :java_test_2
  end
  resources :posts do
    resources :comments
  end

  # devise
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  devise_scope :user do
    root "devise/sessions#new"
  end 

end
