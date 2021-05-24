Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :merchants]
      end
      resources :items, only: [:index, :show, :create, :update, :delete]
    end
  end
end
