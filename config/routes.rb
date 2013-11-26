Wolf::Application.routes.draw do
  #for omniauth
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy"

end
