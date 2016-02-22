Spree::Core::Engine.routes.draw do
	namespace :api do		
  		resources :email_subscriptions, only: [:index, :show, :create]

  		put "/email_subscriptions/" => "/spree/api/email_subscriptions#update" 
  	end
  # Add your extension routes here
end
