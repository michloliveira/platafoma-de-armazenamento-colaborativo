Rails.application.routes.draw do

  devise_for :users,
  #path: '',
  #defaults: { format: :json }
  #path_names: {
   #              sign_in: 'login',
    #             sign_out: 'logout',
     #            sign_up: 'sign_up'
      #         },
  #controllers: {
  #               sessions: 'sessions',
   #              sign_up: 'registrations'
    #           }
    
    controllers: { sessions: :sessions },                   
    path_names: { sign_in: :login }

    
  resource :user, only: [:show, :update]
  resources :arquivos

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #root to: "sessions#new"
  root "static_pages#index"
  get "downloads/:id", to: "downloads#new", as: "download_arquivo" 

end
