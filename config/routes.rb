Cama::Application.routes.draw do
  devise_for :users
  root "statics#index"

  resources :product_cates, :only => [:index, :show] do
    resources :products, :only => [:show]
  end

  resources :cart, :only => [:index, :create] do
    collection do
      get "check", "finish"
      
      #金流串接
      get "post_order/:id" => "cart#post_order", :as => "post_order"
      get "receive_result" => "cart#receive_result"

      match "add" => "cart#add" , :via => :post
    end

    member do
      match "plus" => "cart#plus" , :via => :post
      match "minus" => "cart#minus" , :via => :post
      match "delete" => "cart#delete" , :via => :delete
    end
  end

  namespace :useradmin do
    resources :orders, :only => [:index, :show] do
      member do
        resources :orderasks, :only => [:create]
      end
    end

    root "orders#index"
  end

  namespace :admin do
    resources :product_cates, :except => [:new, :edit] do
      resources :products, :except => [:index, :new] do
        member do
          match :change_status, :via => :post
        end

        resources :stocks, :only => [:index, :create, :update, :destroy]
      end
    end

    resources :orders, :only => [:index, :show]
    resources :orderasks, :only => [:index, :update]
    resources :users, :only => [:index]

    root "product_cates#index"
  end
end