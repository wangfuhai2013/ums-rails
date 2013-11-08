Ums::Engine.routes.draw do

    root :to => 'users#welcome'
	get "users/login" 
    post "users/login"
    get "users/password"
    post "users/password"
    get "users/profile"
    patch "users/profile"    
    get "users/logout" 
    get "users/welcome" 
    resources :users
    resources :roles
    resources :functions
    resources :logs
end
