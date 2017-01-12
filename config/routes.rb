Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "restaurants#index"
  
  get 'restaurants' => 'restaurants#index'
  resources :restaurants, shallow: true do
    resources :reviews do
      resources :endorsements
    end
  end

end
