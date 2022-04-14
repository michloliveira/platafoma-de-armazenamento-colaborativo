Rails.application.routes.draw do
  devise_for :users,
    controllers: { 
      sessions: :sessions,
      sign_up: :registrations
     },                   
    path_names: { 
      sign_in: :login,
      sign_out: :logout,
      sign_up: :sign_up

     }

  resources :arquivos
  
  
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