Rails.application.routes.draw do

  # for java simulation call
  get 'simulation/show'
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

  post 'groups/run_sim'

  # devise
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  devise_scope :user do
      authenticated :user do
        root 'welcome#index', as: :root
      end
      unauthenticated do
        root 'devise/sessions#new', as: :unauthenticated_root
      end
  end 

end
