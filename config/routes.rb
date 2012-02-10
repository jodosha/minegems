Minegems::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }

  constraints(Minegems::Rack::SubdomainRouter) do
    match "/" => "dashboard#index"
  end

  root :to => "home#index"
  resources :subdomains, :only => [ :create ] do
    collection do
      get 'search'
    end
  end

  resources :gems
  resources :early_birds, :only => [ :index, :create ]
  resource  :settings, :only => [ :show, :update ]
  get "ping" => "ping#index"

end
