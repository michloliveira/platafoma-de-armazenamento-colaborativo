Rails.application.routes.draw do

  devise_for :users,
  
    controllers: { 
      sessions: :sessions
     },                   
    path_names: { 
      sign_in: :login
     }

    
  resources :arquivos

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #root to: "sessions#new"
  root "static_pages#index"
  get "downloads/:id", to: "downloads#new", as: "download_arquivo" 

end
