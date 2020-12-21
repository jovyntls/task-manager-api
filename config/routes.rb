Rails.application.routes.draw do
  resources :items_tags
  resources :tags
  resources :cats
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :users, only: [:create]
  post '/login', to: 'users#login'
  post '/signup', to: 'users#create'
  get '/auto_login', to: 'users#auto_login'
  get '/tasks/cat/:cat_id', to: 'tasks#catid'
  get '/items_tags/cat/:cat_id', to: 'items_tags#catid'
  get '/items_tags/cat/:tag_id', to: 'items_tags#tagid'
end
