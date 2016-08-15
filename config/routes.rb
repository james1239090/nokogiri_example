Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'trunk_lines#index'
  resources :trunk_lines do |variable|
    get :autocomplete_trunk_line_full_address, :on => :collection
  end
end
