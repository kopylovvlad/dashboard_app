Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # TODO: test
  root to: 'home#index'
  # TODO: test
  get '*unmatched_route', to: 'application#render_not_found'
  # TODO: test
  get '/500', to: 'application#render_error'
end
