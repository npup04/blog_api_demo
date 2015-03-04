Rails.application.routes.draw do
  resources :posts, only: [:index, :create, :show, :update, :destroy] do
    resources :comments, only: [:index, :create]
  end
    resources :comments, only: [:index, :update, :destroy]
end
