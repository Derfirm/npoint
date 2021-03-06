Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  devise_scope :user do
    get 'users/me' => 'sessions#info'
    patch 'users/me' => 'sessions#update'
    get 'users/me/image' => 'sessions#image'
  end

  post 'users/send_reset_password_email' => 'reset_password#send_reset_password_email'
  post 'users/reset_password' => 'reset_password#reset_password'

  constraints :subdomain => 'api' do
    namespace :api, path: nil, defaults: { format: 'json' } do
      match '/:token(/*path)', to: 'documents#show', via: [:get, :options]
      match '/:token(/*path)', to: 'documents#update', via: [:post, :options]
      root to: 'info#index'
    end
  end

  root 'app#index'
  get 'account', to: 'app#index'
  get 'changelog', to: 'app#index'
  get 'docs', to: 'app#index'
  get 'docs/:id', to: 'app#index'
  get 'faq', to: 'app#index'
  get 'reset-password', to: 'app#index'

  resources :documents, param: :token, only: [:index, :create, :show, :update, :destroy] do
    member do
      post :clone
    end
  end

  resources :schema, only: [] do
    collection do
      post :validate
      post :generate
    end
  end
end
