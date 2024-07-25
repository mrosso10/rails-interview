Rails.application.routes.draw do
  resources :todo_items
  namespace :api do
    resources :todo_lists, only: %i[index create], path: :todolists
  end

  resources :todo_lists

  root 'todo_lists#index'
end
