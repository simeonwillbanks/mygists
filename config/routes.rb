Mygists::Application.routes.draw do
  match 'help', as: :help,
                via: :get,
                controller: :help,
                action: :index

  match ':username', as: :profile,
                     via: :get,
                     controller: :profile,
                     action: :show

  match ':username/tags/:id', as: :tag,
                     via: :get,
                     controller: :tags,
                     action: :show

  root :to => 'home#index'
end
