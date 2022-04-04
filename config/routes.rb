Rails.application.routes.draw do
  devise_for :users,
  path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 sign_up: 'sign_up'
               },
  controllers: {
                 sessions: 'sessions',
                 sign_up: 'registrations'
               }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "static_pages#index"
end
