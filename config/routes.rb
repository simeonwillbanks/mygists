MyGists::Application.routes.draw do

  devise_scope :user do
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match "help", as: :help,
                via: :get,
                controller: :help,
                action: :index

  match ":username", as: :profile,
                     via: :get,
                     controller: :profile,
                     action: :show

  match ":username/tags/:slug", as: :tag,
                                via: :get,
                                controller: :tags,
                                action: :show

  match ":username/tags", as: :tags,
                          via: :get,
                          controller: :tags,
                          action: :index

  root :to => "home#index"
end
