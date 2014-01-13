Wolf::Application.routes.draw do
  resources :posts, :only => [:show, :new, :create]
  resources :user_relationships, :only => [:update]
  resources :users, :only => [:index, :update, :show, :all_usres,:other_accounts, :twitter], :shallow => true do
    member do
      get :all_users
      post :twitter
      get :other_accounts 
    end
  end

  #for omniauth
  get "/logout" => "sessions#destroy", as: "logout"
  get "/auth/:provider/callback", to: "sessions#create", as: "sessions"
  root :to => "sessions#sign_in"
end
