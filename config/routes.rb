Rails.application.routes.draw do

  root "photos#index"

  get "upload", to: "uploads#index"
  post "upload", to: "uploads#create"

end
