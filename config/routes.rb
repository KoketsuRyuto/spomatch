Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'users#index'
    resources :users, only: [:show,:edit,:update]
    resources :sports, only: [:index,:create,:edit,:update,:destroy]
    resources :tags, only: [:index,:create,:edit,:update]
    resources :posts, only: [:index,:show,:destroy] do
      resources :post_comments, only: [:index,:destroy]
    end
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: [:show,:edit,:update]
    get 'users/:id/confilm' => 'users#confilm',as:"users/confilm"
    patch 'users/:id/withdraw' => 'users#withdraw',as:"users/withdraw"
    resources :posts do
      resources :post_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    get "search_tag" => "posts#search_tag"
    get "search_sport" => "groups#search_sport"
    resources :groups do
      resources :group_chats, only: [:show,:create]
      get 'join' => 'groups#join'
      delete 'withdraw' => 'groups#withdraw'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
