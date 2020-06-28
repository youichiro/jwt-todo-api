Rails.application.routes.draw do
  scope :api do
    resources :sessions, only: [:create]
    resources :users, only: [:create, :show]
    resources :tasks, only: [:index, :show, :create, :update, :destroy]
  end
end
