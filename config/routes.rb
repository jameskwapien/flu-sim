Rails.application.routes.draw do
 
  # for java simulation call
  get 'simulation/show'
  resources :outputs
  resources :inputs
  resources :simulations
  resources :posts do
    resources :comments
  end
  resources :memberships
  resources :groups
  resources :simulations do
    put :java_test_2
  end

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :groups
  devise_scope :user do
      authenticated :user do
        root 'welcome#index', as: :root
      end
      unauthenticated do
        root 'devise/sessions#new', as: :unauthenticated_root
      end
  end 

end
