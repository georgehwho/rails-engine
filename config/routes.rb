Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'

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
