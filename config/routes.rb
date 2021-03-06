Rails.application.routes.draw do
  resources :documentos_simposios
  resources :videos_simposios
  resources :simposios
  resources :eventos
  resources :documentos
  
  
  get 'password_resets/new'

  get 'password_resets/edit'

  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  get 'sessions/new'

  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :users
  resources :account_activations, only: [:edit]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  post '/lostemail', to: 'users#lostemail'
  
  patch 'editemailupdate' => 'users#editemailupdate'
  patch 'editpasswordupdate' => 'users#editpasswordupdate'
  
  patch 'addvideo' => 'videos_simposios#addvideo'
  patch 'adddoc' => 'documentos_simposios#adddoc'
  
  get 'dashboard' => 'pages#dashboard'
  get 'users_simposios' => 'pages#simposios'
  get 'user_aprove_image' => 'users#aprove_user_image'
  get 'aceitar_foto' => 'pages#aprovacao_imagens'
  get 'aceitar_doc' => 'documentos#aceitar_doc'
  get 'aprove_doc' => 'documentos#aprove_doc'
  get 'fotos' => 'users#fotos'
  get 'arquivo_show' => 'pages#arquivo_show'
  get 'editemail' => 'users#editemail'
  get 'editpassword' => 'users#editpassword'
  get 'recuperacao' => 'pages#recuperacao'
  get 'publicacoes'    => 'pages#publicacoes'
  get 'arquivos' => 'pages#arquivos'
  get 'tese_view' => 'pages#tese_view'
  get 'linhasdepesquisa'    => 'pages#linhasdepesquisa'
  get 'painel'    => 'pages#painel'
  get 'teses'    => 'pages#teses'
  get 'parceiros'    => 'pages#parceiros'
  get 'colaboradores' => 'pages#colaboradores'
  get 'instituicoes'  => 'pages#instituicoes'
  get 'events'    => 'pages#eventos'
  get 'coordenadores'    => 'pages#coordenadores'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

end
