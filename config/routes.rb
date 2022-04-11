Rails.application.routes.draw do

  
  resources :arquivos
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, :only => [:show]
  
  get "downloads/:id", to: "downloads#new", as: "download_arquivo" 
  root "static_pages#index"
end

# defaults: { format: :json },
# devise_for :users,
# path: '',
# path_names: {
  #              sign_in: 'login',
#                sign_out: 'logout',
#                sign_up: 'sign_up'
#              },
# controllers: {
#                sessions: 'sessions',
#                sign_up: 'registrations'
#              }