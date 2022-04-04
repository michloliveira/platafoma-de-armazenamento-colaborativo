Rails.application.routes.draw do
  resources :arquivos
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "arquivos#index"
  #root "static_pages#index"
end
