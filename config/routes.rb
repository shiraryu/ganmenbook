Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :topics,only:[:index,:new,:create,:edit,:update,:destroy]do
    collection do
      post :confirm
    end
  end

  devise_for :users,controllers:{
    registrations:"users/registrations",
    omniauth_callbacks:"users/omniauth_callbacks"
  }

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
