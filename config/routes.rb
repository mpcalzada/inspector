Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do

    resources :landing

    get 'about' => 'landing#about'
    get 'home_landing' => 'landing#index'


    resources :accounts
    resources :providers
    resources :clients
    resources :loans
    resources :departments
    resources :attendance_tracker
    resources :upload_files
    resources :home
    resources :employers
    resources :degrees

    get 'dashboard/home_dashboard'
    get 'dashboard/accountancy_dashboard', as: :accountancy_dashboard
    get 'dashboard/human_resources_dashboard'
    get 'dashboard/reports_dashboard'

    get 'reports/attendance_tracking', as: :attendance_report
    get 'reports/accountancy_report', as: :accountancy_report

    post 'attendance/historic/:id', to: 'attendance_tracker#employer_history'
    post 'attendance/historic', to: 'attendance_tracker#full_history'

    put 'employers/:id/attach_document', to: 'employers#attach_document'
    put 'employers/:id/add_roles', to: 'employers#add_roles'
    post 'employers/:id/enable_user', to: 'employers#enable_user'

    post 'loans/prepayment', to: 'loans#prepayment'
    post 'loans/:id/penalize', to: 'loans#penalize', as: :penalize_loan
    post 'loans/:id/pay_monthly', to: 'loans#pay_monthly', as: :pay_monthly

    put '/porcentual_filter_details/:id', to: 'porcentual_filter_details#create'

    authenticated :user do

      root to: 'home#index', as: :authenticated_root
    end

    unauthenticated :user do
      root :to => 'landing#index', as: :unauthenticated_root
    end
  end
end
