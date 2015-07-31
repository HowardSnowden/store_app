Rails.application.routes.draw do

  resources :orders
  put 'fill_order/:id', to: 'orders#fill_order', as: 'fill_order'
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations', passwords: 'passwords'}
  
  resources :line_items

  resources :carts
  
  
  root 'pages#index'

  get 'index' 	=> 'pages#index' 
  get 'tips'		=> 'pages#tips'
  get 'contact'	=> 'pages#contact'
  get 'about'		=> 'pages#about'
  get 'articles' => 'pages#articles'
  get 'videos'  => 'pages#videos'
  get 'welcome/index'	=> 'welcome#index'
  resources :products
  


end
