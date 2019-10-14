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

  resources :users, except: [:create,:new]
  resources :users do
    collection do
      post :import
    end
  end

  get '/salaries', to: 'users#json'


  #deplacement routes

  resources :deplacements, except: [:show]

  get 'deplacements/getvehicule' => 'deplacements#getvehicule'
  get 'deplacements/:id/valider/' => 'deplacements#valider'
  get 'users/deplacements/:id/valider/' => 'deplacements#valider'
  get 'deplacements/new/fraisdivers' => 'deplacements#fraisdivers'
  post 'deplacements/export/', to: 'deplacements#export', as: 'deplacements_export'

  get 'pdf/:id' => 'pages#pdf', as: 'pdf'
  get 'csv/:id' => 'pages#csv', as: 'csv'
end
