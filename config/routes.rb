Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    resources :landing

    authenticated :user do

      resources :upload_files
      resources :home
      resources :employers
      resources :degrees

      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
      root to: 'home#index'
    end

    unauthenticated :user do
      #root :to => 'devise/sessions#new', as: :unauthenticated_root
      root :to => 'landing#index', as: :unauthenticated_root
    end
  end
end
