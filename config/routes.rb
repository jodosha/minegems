Minegems::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }

  constraints(subdomain: /.+/) do
    get "/" => "dashboard#index", as: "dashboard"
    resources :gems, only: %w( index new create show )
  end

  root :to => "home#index"
  resources :subdomains, :only => [ :create ] do
    collection do
      get 'search'
    end
  end

  resources :early_birds, :only => [ :index, :create ]
  resource  :settings, :only => [ :show, :update ]
  get "ping" => "ping#index"

end
