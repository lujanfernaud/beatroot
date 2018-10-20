Rails.application.routes.draw do
  root "tracks#index"

  resources :xml_downloads, only: [:create]
end
