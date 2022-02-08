Rails.application.routes.draw do
  devise_for :customers, module: "customers"
  devise_for :admins, module: "admins"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    root "orders#top"
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
    resources :customers, except: [:new, :create, :destroy]
    get "/customers/my_page" => "customers#show"
    resources :orders, only: [:show]
  end

  scope module: :public do
  root "homes#top"
  get "/about" => "homes#about"
  resources :customers, only: [:edit, :update, :destroy]
  get "/customers/my_page" => "customers#show"
  get "/customers/quit" => "customers#quit"
  patch "/customers/out" => "customers#out"
  resources :addresses, except: [:new, :show]
  resources :items,  only: [:index, :show]
  resources :cart_items, only: [:index, :update, :destroy, :create]
  delete "/cart_items/destroy_all" => "cart_items#destroy_all"
  resources :orders, only:[:new, :create, :index, :show]
  post "/orders/log" => "orders#log"
  get "/orders/complete" => "orders#complete"
end
end