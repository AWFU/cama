Cama::Application.routes.draw do
  root 'statics#index'

  resources :products, :only => [:index, :show]

  namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :products

    root 'products#index'
  end
end