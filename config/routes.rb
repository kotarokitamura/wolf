Wolf::Application.routes.draw do
  #for omniauth
  get "/logout" => "sessions#destroy", as: "logout"
  get "/auth/:provider/callback", to: "sessions#create", as: "sessions"
  root :to => "sessions#sign_in"
end
