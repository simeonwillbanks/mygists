MyGists::Application.routes.draw do

  devise_scope :user do
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match "search", as: :search,
                  via: :get,
                  controller: :search,
                  action: :index

  match "help", as: :help,
                via: :get,
                controller: :help,
                action: :index

  match "tags/:slug", as: :tag,
                      via: :get,
                      controller: :tags,
                      action: :show

  match "tags", as: :tags,
                via: :get,
                controller: :tags,
                action: :index

  match ":username", as: :profile,
                     via: :get,
                     controller: :profile,
                     action: :show

  match ":username/tags/:slug", as: :profile_tag,
                                via: :get,
                                controller: "profile/tags",
                                action: :show

  match ":username/tags", as: :profile_tags,
                          via: :get,
                          controller: "profile/tags",
                          action: :index

  root :to => "home#index"
end
