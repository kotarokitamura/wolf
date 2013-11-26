Wolf::Application.routes.draw do
  #for omniauth
  resources :sessions, only: :destroy, as: "logout"
  get "/auth/:provider/callback", to: "sessions#create", as: "sessions"
end
