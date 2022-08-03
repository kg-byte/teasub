Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/subscriptions', to: 'subscriptions#create'
  put '/subscriptions', to: 'subscriptions#update'
  get 'customers/:id/subscriptions', to: 'subscriptions#index'
end