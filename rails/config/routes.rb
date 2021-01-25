Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, :controllers => {:registrations => "registrations"}
  root 'home#index' 
    resources :users do
        get 'export_all'
        resources :books do
            get 'export_all_notes'
            resources :notes do 
              get 'export'
            end
        end
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
