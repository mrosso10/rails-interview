Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index show create update destroy], path: :todolists do
      resources :todo_items, only: %i[index show create update destroy], path: :todoitems
    end
  end

  resources :todo_lists, path: :todolists do
    resources :todo_items, only: %i[new create edit update destroy], path: :todoitems
  end

  root 'todo_lists#index'
end
