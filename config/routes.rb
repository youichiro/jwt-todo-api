Rails.application.routes.draw do
  scope :api do
    resources :tasks, only: [:index, :show, :creare, :update, :destroy]
  end
end
