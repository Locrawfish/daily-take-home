Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "videos#index"

  post "/videos", to: "videos#create"
  get "/show", to: "videos#show"

  get "/metrics", to: "metrics#index"
  get "/sessions", to: "metrics#show"
  post "/metrics", to: "metrics#create"
  get "/participant_time", to: "metrics#get_total_participant_time"
end
