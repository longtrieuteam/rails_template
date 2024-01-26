Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  root to: 'admin/dashboard#index'

  namespace :api do
    namespace :v2 do
      namespace :auth do
        resources :token, only: [:create] do
          collection do
            get :profile
            post :refresh
          end
        end
      end
      resources :users, only: %i[create] do
        collection do
          put :update_password
          put :update_role
          put :update_info
          post :forgot_password
          post :reset_password
        end
      end
    end
  end
end
