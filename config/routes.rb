Rails.application.routes.draw do
  root :to => 'homes#home'
  get 'home/about' => 'homes#about' ,as: 'about'


  devise_for :users
  

  resources :books
  resources :users, only: [:index, :show, :edit, :update]
end
