Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  get 'sessions/new'

  resources :users
  resources :account_activations, only: [:edit]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  post '/lostemail', to: 'users#lostemail'
  
  patch 'editemailupdate' => 'users#editemailupdate'
  patch 'editpasswordupdate' => 'users#editpasswordupdate'
  
  get 'arquivo_show' => 'pages#arquivo_show'
  get 'editemail' => 'users#editemail'
  get 'editpassword' => 'users#editpassword'
  get 'recuperacao' => 'pages#recuperacao'
  get 'publicacoes'    => 'pages#publicacoes'
  get 'arquivos' => 'pages#arquivos'
  get 'linhasdepesquisa'    => 'pages#linhasdepesquisa'
  get 'painel'    => 'pages#painel'
  get 'teses'    => 'pages#teses'
  get 'parceiros'    => 'pages#parceiros'
  get 'colaboradores' => 'pages#colaboradores'
  get 'instituicoes'  => 'pages#instituicoes'
  get 'eventos'    => 'pages#eventos'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
