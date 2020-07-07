Rails.application.routes.draw do

  resources :loans
  devise_for :users

  devise_scope :user do

    resources :landing

    get 'about' => 'landing#about'
    get 'home_landing' => 'landing#index'

    authenticated :user do
      resources :departments
      resources :attendance_tracker
      resources :upload_files
      resources :home
      resources :employers
      resources :degrees

      put 'employers/:id/attach_document', to: 'employers#attach_document'
      put 'employers/:id/add_roles', to: 'employers#add_roles'
      post 'employers/:id/enable_user', to: 'employers#enable_user'

      put '/porcentual_filter_details/:id', to: 'porcentual_filter_details#create'


      root to: 'home#index', as: :authenticated_root
    end

    unauthenticated :user do
      root :to => 'landing#index', as: :unauthenticated_root
    end
  end
end
