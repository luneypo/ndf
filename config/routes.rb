Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  # end

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

  #deplacement routes

  resources :deplacements, except: [:show]

  get 'deplacements/export/' => 'deplacements#export'
  get 'deplacements/:id/valider/' => 'deplacements#valider'
  get 'users/deplacements/:id/valider/' => 'deplacements#valider'
  get 'deplacements/new/fraisdivers' => 'deplacements#fraisdivers'

end
