# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }, path_names: { sign_in: :login }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks do
    get :index_open_tasks, on: :collection
    get :index_close_tasks, on: :collection
    resources :comments, only: %i[index new create destroy]
  end

  root to: 'tasks#index'
end
