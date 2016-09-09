Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  resources :account_activations, only: [:edit]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  patch 'editemailupdate' => 'users#editemailupdate'
  patch 'editpasswordupdate' => 'users#editpasswordupdate'
  get 'editemail' => 'users#editemail'
  get 'editpassword' => 'users#editpassword'
  get 'publicacoes'    => 'pages#publicacoes'
  get 'linhasdepesquisa'    => 'pages#linhasdepesquisa'
  get 'teses'    => 'pages#teses'
  get 'parceiros'    => 'pages#parceiros'
  get 'eventos'    => 'pages#eventos'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
