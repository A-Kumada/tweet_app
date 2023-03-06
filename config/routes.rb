Rails.application.routes.draw do

devise_for :users,skip: [:passwords], controllers: {
 registrations: "public/registrations",
 sessions: 'public/sessions'
 }

  root to: "public/tweets#index"
  get "/users/unsubscribe" => "public/users#unsubscribe", as: "unsubscribe"
  patch '/users/:id/withdraw' => 'public/users#withdraw', as: "withdraw"
  post 'like/:id' => 'public/likes#create', as: 'create_like'
  delete 'like/:id' => 'public/likes#destroy', as: 'destroy_like'

  scope module: :public do
    resources :users, only: [:edit, :update, :show] do
      member do
        get :following, :followers
      end
    end
    resources :tweets, only: [:create, :index, :show, :edit, :update, :destroy] do
      #resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy] 
    end
    resources :relationships, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
  end

end
