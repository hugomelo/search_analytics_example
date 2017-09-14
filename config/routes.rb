require 'sidekiq/web'

Rails.application.routes.draw do
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  mount Sidekiq::Web => '/sidekiq'
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

  root to: 'welcome#index'

  namespace :api do
    resources :search
    resources :search_analytics, only: [:index, :show]
  end
end
