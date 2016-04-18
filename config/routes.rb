Rails.application.routes.draw do

  resources :groups
  resources :memberships
  resources :enrollments
  resources :courses
  resources :outputs
  resources :inputs
  resources :posts do
    resources :comments
  end

  get 'calendar/index'

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
