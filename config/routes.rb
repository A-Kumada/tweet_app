Rails.application.routes.draw do
  
devise_for :users,skip: [:passwords], controllers: {
 registrations: "public/registrations",
 sessions: 'public/sessions'
 }
 
  root to: "public/tweets#index"
  
  scope module: :public do
    resources :users, only: [:edit, :update, :show] do
      member do
        get :following, :followers
      end
    end
    resources :tweets, only: [:create, :index, :show, :edit, :update, :destroy] 
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  
  namespace :admin do
  end
  
end
