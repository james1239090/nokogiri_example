Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'trunk_lines#index'
  resources :trunk_lines do
    member do
      get :search
    end
  end
end
