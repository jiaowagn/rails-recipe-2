Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations
  end

  namespace :admin do
    root "events#index"
    resources :events do
      collection do
        post :bulk_update
      end
      member do
        post :reorder
      end
      resources :tickets, :controller => "event_tickets"
    end
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
  end

  get "/faq" => "pages#faq"

  resource :user

  root "events#index"

end
