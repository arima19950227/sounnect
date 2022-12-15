Rails.application.routes.draw do

# ユーザー用
# URL /customers/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations,:passwords], controllers: {
  sessions: "admin/sessions"
}


scope module: :public do
   root to: "homes#top"
   get "about" => "homes#about"

   resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
     collection do
      get 'search'
     end
  end
   get "users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
   patch "userrs/:id/withdraw" => "users#withdraw", as: "withdraw"

   resources :reviews do
    resource :favorites, only: [:create,:destroy]
     resources :comments, only: [:create,:destroy] do
     resources :comment_favorites, only: [:create,:destroy]
    end
   end

   resources :rooms, only: [:create,:show]
   resources :messages, only: [:create]
  end


   namespace :admin do
   root to: "homes#top"
   resources :users, only: [:index,:show,:edit,:update] do
     collection do
      get 'search'
     end
    end
   resources :reviews, only: [:index,:show,:edit,:update,:destroy]do
     resources :comments, only: [:destroy]
    end
  end

  devise_scope :user do
   post 'users/guest_sign_in' => 'public/sessions#new_guest', as: 'guest'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
