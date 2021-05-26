Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          resources :items, only: [:index]
        end
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        scope module: :items do
          resources :merchant, only: [:index]
        end
      end
    end
  end
end
