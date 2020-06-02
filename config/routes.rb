Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user/registrations", :sessions => "user/sessions"}, path: 'auth',
             path_names: {sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
                          unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'}

  resources :landing

  devise_scope :user do

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
