Errbit::Application.routes.draw do
  
  devise_for :users

  # Hoptoad Notifier Routes
  match '/notifier_api/v2/notices' => 'notices#create'
  match '/deploys.txt' => 'deploys#create'

  resources :settings, :only => [:index, :edit]
  resources :notices, :only => [:show]
  resources :deploys, :only => [:show]
  resources :users
  resources :errs,    :only => [:index] do
    collection do
      get :all
    end
  end
  
  resources :apps do
    resources :errs do
      resources :notices
      member do
        put :resolve
        post :create_issue
        delete :clear_issue
      end
    end

    resources :deploys, :only => [:index]
  end
  
  root :to => 'apps#index'
  
end
