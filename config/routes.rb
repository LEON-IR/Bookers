Rails.application.routes.draw do


  devise_for :users
  devise_scope :user do
  	get 'user/sign_up' => 'devise/registrations#new'
  end

  get 'userinfos/new'
  get '/home/about' => "root#about"

  root 'root#top'
	  resources :users, only: [:index, :show, :edit, :update]
	  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :book_images, only: [:new, :create, :index, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
