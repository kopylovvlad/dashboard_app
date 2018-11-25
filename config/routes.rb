Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  resources :user_dashboards, except: :show
  get '*unmatched_route', to: 'application#render_not_found'
  get '/500', to: 'application#render_error'
end
