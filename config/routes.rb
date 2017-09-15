Rails.application.routes.draw do
  
  get 'relationships/create'

  get 'relationships/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :topics do
    resources :comments
    post :confirm ,on: :collection
  end

  devise_for :users,controllers:{
    registrations:"users/registrations",
    omniauth_callbacks:"users/omniauth_callbacks"
  }

  resources :users, only: [:index, :show]
  resources :relationships,only:[:create,:destroy]

  resources :conversations do
    resources :messages
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine,at:'/letter_opener'
  end

  authenticated :user do                                                 # Userがログイン中はtopic一覧をtop画面とする設定
    root :to => "topics#index", :as => "user_authenticated_root"
  end

  devise_scope :user do                                                  # User非ログイン中はサインアップ画面をtop画面とする設定
    root :to => "users/registrations#new"                                # RegistrationsControllerのnew.html.erbに飛ばしている
  end
end
