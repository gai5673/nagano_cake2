Rails.application.routes.draw do
  devise_for :customers, module: "customers"
  devise_for :admins, module: "admins"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    
  end
end
