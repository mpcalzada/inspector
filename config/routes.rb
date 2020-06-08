Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do

    resources :landing

    authenticated :user do
      resources :departments
      resources :attendance_tracker
      resources :upload_files
      resources :home
      resources :employers
      resources :degrees

      put 'employers/:id/attach_document', to: 'employers#attach_document'

      put '/porcentual_filter_details/:id', to: 'porcentual_filter_details#create'


      root to: 'home#index', as: :authenticated_root
    end

    unauthenticated :user do
      root :to => 'landing#index', as: :unauthenticated_root
    end
  end
end
