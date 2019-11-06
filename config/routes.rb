Rails.application.routes.draw do

  post "/graphql", to: "graphql#execute"

  get 'users_import/new'

  get 'users_import/create'

  # home pages

  root 'pages#home'


  # users routes

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations:  'users/registrations',
      passwords:  'users/passwords',
      confirmations: 'users/confirmations'
  }

  resources :users, except: :show
  resources :users do
    collection do
      post :import
    end
  end

  get '/salaries', to: 'users#json'


  #deplacement routes

  resources :deplacements, except: [:index,:show]
  get 'deplacements/admin' => 'deplacements#index_admin'
  get 'deplacements/getvehicule' => 'deplacements#getvehicule'
  get 'deplacement/:id/valider/' => 'deplacements#valider'
  get 'deplacements/fraisdivers' => 'deplacements#fraisdivers'
  post 'deplacements/export/', to: 'deplacements#export', as: 'deplacements_export'
  get 'deplacements/show/', to: 'deplacements#show_my_deplacements', as: 'show_my_deplacements'
  get 'deplacements/show/:id', to: 'deplacements#show_deplacements', as: 'show_deplacements'

  get '/pdf/:id' => 'pages#pdf'
  get '/deplacements/pdf/:id' => 'pages#pdf', as: 'pdf'
  get '/deplacements/csv/:id' => 'pages#csv', as: 'csv'
end
