Wolf::Application.routes.draw do
  resources :posts, :only => [:show, :new, :create, :update], :shallow => true do
    resources :comments, :only => [:index, :create, :new]
  end
  resources :user_relationships, :only => [:update]
  resources :users, :only => [:index, :update, :show,:other_accounts, :twitter], :shallow => true do
    member do
      post :twitter
      get :other_accounts
    end
  end
  get "all_users" => "users#all_users"

  get "/logout" => "sessions#destroy", as: "logout"
  get "/auth/:provider/callback", to: "sessions#create", as: "sessions"
  root :to => "sessions#sign_in"
end
