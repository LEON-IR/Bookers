Rails.application.routes.draw do


  devise_for :users
  devise_scope :user do
  	get 'user/sign_up' => 'devise/registrations#new'
  end

  get 'userinfos/new'
  get '/home/about' => "root#about"

  root 'root#top'
	  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:create, :index, :show, :edit, :update,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end
