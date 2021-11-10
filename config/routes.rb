Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :scores, only: [:show, :create, :destroy]
      post "/filter_score", to: "scores#filter_score"
      post "/player_history", to: "scores#player_history"
    end
  end
end
