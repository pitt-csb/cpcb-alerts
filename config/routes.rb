Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' } # Use custom class for registration
  resources :events
  root 'static_pages#home'
end
