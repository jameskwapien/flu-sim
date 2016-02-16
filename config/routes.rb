Rails.application.routes.draw do

  # devise authentication gem routes
  root "main#index"
  
  # authenticated :user do
  #   root :to => "main#index"
  # end

  # unauthenticated :user do
  #   devise_scope :user do 
  #     root :to => "devise/sessions#new", as: :unauthenticated_root
  #   end
  # end
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :groups, :main
  
  resources :posts do
    resources :comments
  end

end
