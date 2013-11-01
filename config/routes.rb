Ums::Engine.routes.draw do
	get "users/login" 
    post "users/login"
    get "users/password"
    post "users/password"
    get "users/profile"
    patch "users/profile"    
    get "users/logout" 
    resources :users
    resources :roles
    resources :functions
    resources :logs
end
