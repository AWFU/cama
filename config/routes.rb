Cama::Application.routes.draw do
  root 'statics#index'

  resources :product_cates, :only => [:index, :show] do
    resources :products, :only => [:show]
  end

  namespace :admin do
    resources :product_cates, :except => [:new, :edit] do
      resources :products, :except => [:index, :new] do
        member do
          match :change_status, :via => :post
        end
      end
    end

    root 'product_cates#index'
  end
end