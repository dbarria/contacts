Rails.application.routes.draw do
  resources :contacts do
    get 'search', on: :collection
    get 'home', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'contacts#home'
end
