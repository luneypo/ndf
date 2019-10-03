Rails.application.routes.draw do

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


  #deplacement routes

  resources :deplacements, except: [:show]

  get 'deplacements/:id/valider/' => 'deplacements#valider'
  get 'users/deplacements/:id/valider/' => 'deplacements#valider'
  get 'deplacements/new/fraisdivers' => 'deplacements#fraisdivers'

end
