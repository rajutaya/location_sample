Rails.application.routes.draw do
  root :to =>'locations#index', :as => :dashboard
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
