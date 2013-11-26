Wolf::Application.routes.draw do
  #get "users/index"
  #get "posts/show"
  resources :users, :only => [:index], :shallow => true do
    resources :posts, :only => [:show]
  end
  #for omniauth
  get "/logout" => "sessions#destroy", as: "logout"
  get "/auth/:provider/callback", to: "sessions#create", as: "sessions"
  root :to => "sessions#sign_in"
end
