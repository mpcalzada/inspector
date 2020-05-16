Rails.application.routes.draw do
  resources :departments
  devise_for :users

  devise_scope :user do
    resources :landing

    authenticated :user do

      resources :upload_files
      resources :home
      resources :employers
      resources :degrees

      root to: 'home#index', as: :authenticated_root
    end

    unauthenticated :user do
      root :to => 'landing#index', as: :unauthenticated_root
    end
  end
end
