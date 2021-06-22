Rails.application.routes.draw do

  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  post "/sessions" => "sessions#create"

  get "/favorites" => "favorites#index"
  post "/favorites" => "favorites#create"
  delete "/favorites/:id" => "favorites#destroy"
  
  get "/ingredients" => "ingredients#index"
  post "/ingredients" => "ingredients#create"
  patch "/ingredients/:id" => "ingredients#update"
  delete "/ingredients/:id" => "ingredients#destroy"

  get "/recipes" => "recipes#index"
  get "/recipes/:spoonacular_api_id" => "recipes#show"

end
