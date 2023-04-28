Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # ゲストユーザー用のルーティング
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'users#index'
    resources :users, only: [:show,:edit,:update]
    resources :sports, only: [:index,:create,:edit,:update,:destroy]
    resources :tags, only: [:index,:create,:edit,:update]
    resources :posts, only: [:index,:show,:destroy]
    resources :post_comments, only: [:index,:show,:destroy]
  end

  scope module: :public do
    root to: 'homes#about'
    get 'top' => 'homes#top'
    resources :users, only: [:show,:edit,:update]
    get 'users/:id/confilm' => 'users#confilm',as:"users/confilm"
    patch 'users/:id/withdraw' => 'users#withdraw',as:"users/withdraw"
    resources :posts do
      resources :post_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    get "search_tag/:tag_id" => "posts#search_tag",as:"search_tag"
    get "search_sport/:sport_id" => "groups#search_sport",as:"search_sport"
    resources :groups do
      resources :group_chats, only: [:show,:create]
      get 'join' => 'groups#join'
      delete 'withdraw' => 'groups#withdraw'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
