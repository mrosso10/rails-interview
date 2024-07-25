Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index create], path: :todolists
  end

  resources :todo_lists do
    resources :todo_items, only: %i[new create edit update destroy], as: :todo_items
  end

  root 'todo_lists#index'
end
