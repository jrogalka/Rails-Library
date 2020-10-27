Rails.application.routes.draw do
  resources :books, only: %i[index show]
  resources :authors, only: %i[index show]

  get "/" => "pages#index"
  get "about" => "pages#about"
end
