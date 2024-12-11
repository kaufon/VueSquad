Rails.application.routes.draw do
  delete("squads/remove", to: "squads#remove", as: "remove_from_squad")
  resources(:squads, only: [ :create, :index, :destroy, :update ]) do
    post(:add, on: :collection)
  end

  resources(:tasks)
  resources(:users)
  post("/auth/login", to: "authentication#login")
  post("/auth/logout", to: "authentication#logout")
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get("up" => "rails/health#show", :as => :rails_health_check)
  # Defines the root path route ("/")
  # root "posts#index"
end
