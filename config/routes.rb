Cama::Application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :admins, :path => 'camaadministrator', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  root "statics#index"

  get 'about' => 'statics#about', :as => :about
  
  resources :pages, :controller => :statics do 
    collection do
      get ':page', :action => :show, :as => :page
    end
  end
  
  resources :categories, :controller => :product_cates, :only => [ :index, :show] do 
    resources :products, :only => [:show]
  end
  # resources :product_cates, :only => [:index, :show] do
  #   resources :products, :only => [:show]
  # end

  resources :cart, :only => [:index, :create] do
    collection do
      get "check" => "cart#check" , :as => "check"
      get "final_check/" => "cart#final_check", :as => "final_check"
      get "finish"
      get "confirm" => "cart#confirm", :as => "confirm"
      #
      post "set_ship_to/:shipping_to" => "cart#set_ship_to" , :as => "set_ship_to"
      get "fail"
      #金流串接
      get "post_order/:id" => "cart#post_order", :as => "post_order"
      get "receive_result" => "cart#receive_result"

      match "add" => "cart#add" , :via => :post
    end

    member do
      match "plus/:index" => "cart#plus" , :via => :post , :as => "plus"
      match "minus/:index" => "cart#minus" , :via => :post , :as => "minus"
      match "delete_by_attribute/:index" => "cart#delete_by_attribute", :via => :post , :as => "delete_by_attribute"
      match "delete" => "cart#delete" , :via => :delete

    end
  end

  namespace :useradmin do
    
    resources :users, :only => [:index ,:update]
    resources :addressbooks , :only => [:index, :create, :destroy ,:update]
    
    
    resources :orders, :only => [:index, :show] do
      member do
        resources :orderasks, :only => [:new, :create]
        patch :atm_transfered #the only action that user allow to triggered
      end
    end
  
    root "orders#index"

  end

  resources :announcements , :only => [:index, :show]

  resources :talks , :only => [:index, :show] do 
    collection do 
      get 'about/:tag', to: 'talks#index', as: :about
    end
  end

  resources :stores do 
    collection do 
      get 'search', action: 'search'
    end
  end

  get 'fetch_from_country' => 'stores#fetch_from_country'
  get 'fetch_from_city' => 'stores#fetch_from_city'

  namespace :admin do

    authenticated :admin do
      root "orders#index"#, :as => :authenticated_root
    end

      mount RailsAdmin::Engine => '/advanced', as: 'rails_admin'
      
      resources :admins
      
      resources :product_cates, :except => [:new, :edit] do
        resources :products, :except => [:index, :new] do
          member do
            post  'peditor/:id/createPhoto'       => 'peditor#createPhoto'

            get   '/basic_info'       => 'products#basic_info', as: 'basic_info'
            post  '/basic_info'       => 'products#update_basic_info'

            get   '/free_paragraph'       => 'products#free_paragraph'
            post  '/free_paragraph'       => 'products#update'

            post 'create_product_attachment' , :action => 'create_product_attachment'
            post 'create_taste_attachment' , :action => 'create_taste_attachment'
          
            #match :basic_info, :via => :get
            match :productphoto_upload, :via => :get
            match :taste_attributes, :via => :get
            #match :free_paragraph, :via => :get

            match :change_status, :via => :post

            resources :product_stocks, :only => [:index, :create, :update, :destroy]
          end

          
        end

      end

      # resources :banners
      # #admin/index_sliders, admin/selected_products
      resources :index_sliders, controller: 'banners', type: 'IndexSlider' do
        # member do 
        #   # do or not?
        #   patch 'multiple_reorder' , :action => 'multiple_reorder'
        # end
      end

      resources :selected_products, controller: 'banners', type: 'SelectedProduct' do 
        # member do 
        #   # do or not?
        #   patch 'multiple_reorder' , :action => 'multiple_reorder'
        # end
      end

      resources :jobs 

      resources :stores do

        # edit
        member do 
          get 'fetch_from_country' , action: 'fetch_from_country'
          get 'fetch_from_city' , action: 'fetch_from_city'

          post 'create_store_attachment' , :action => 'create_store_attachment'
          match :storephoto_upload, :via => :get
        end

        # new
        collection do 
          get 'fetch_from_country' , action: 'fetch_from_country'
          get 'fetch_from_city' , action: 'fetch_from_city'
        end
      end

      resources :services do 
        member do 
          post 'create_service_attachment' , :action => 'create_service_attachment'
          match :servicephoto_upload, :via => :get        
        end      
      end

      resources :talks do 
        member do
          post  'peditor/:id/createPhoto'       => 'peditor#createPhoto'
          post 'create_talk_attachment' , :action => 'create_talk_attachment'
          match :talkphoto_upload, :via => :get        

          get   '/edit_tags'       => 'talks#edit_tags'
          patch  '/edit_tags'       => 'talks#update_tags'

        end
      end

      resources :announcements do 
        member do
          post  'peditor/:id/createPhoto'       => 'peditor#createPhoto'
          post 'create_announcement_attachment' , :action => 'create_announcement_attachment'
          match :announcementphoto_upload, :via => :get

          get '/custom_edit' => 'announcements#custom_edit'
          patch '/custom_edit' => 'announcements#update'

        end
      end

      resources :customizedpages do
        member do
          post 'create_customizedpage_attachment' , :action => 'create_customizedpage_attachment'
          match :customizedpagephoto_upload, :via => :get
        end
      end

      resources :galleries do 
        member do
          patch 'multiple_reorder' , :action => 'multiple_reorder'
        end 
      end


      resources :orders, :only => [:index, :show] do
        member do 
          #AASM
          post :checkout_succeeded_ATM # should remove
          post :cancel_before_paid_ATM
          post :atm_transfered
          post :money_placed_ATM
          post :atm_comfirmed
          
          post :checkout_succeeded_Vaccount # should remove
          post :cancel_before_paid_Vaccount
          post :comfirmed_Vaccount
          #post :human_involving_after_order_placed
          
          post :checkout_succeeded_COD # should remove
          post :shipping_COD
          post :post_collect_checked
          post :human_involving_after_order_placed_COD
          post :human_involving_post_collect_COD

          post :checkout_succeeded_general # should remove
          post :shipping_first
          post :human_involving_after_order_placed_general

          
          #SHARED
          post :checkout_failed # should remove
          post :shipping

          patch :shipping
          patch :shipping_first
          patch :shipping_COD
          patch :human_involving_after_order_placed_COD
          patch :human_involving_post_collect_COD
          patch :human_involving_after_order_placed_general
          patch :human_involving_after_money_placed
          patch :human_involving_after_money_checked
          patch :human_involving_after_shipped
          patch :human_involved_edit
          

          post :human_involved_edit
          post :human_involving_after_money_placed
          post :human_involving_after_money_checked
          post :human_involving_after_shipped
          post :close_deal
          post :to_abnormal

          get '/info_hub/:event' => 'orders#info_hub'
          post '/info_hub/:event' => 'orders#update_from_info_hub'

          get 'detail' => 'orders#detail'

        end

        collection do
          #金流：查詢交易狀態
          get "query_order_status/:id" => "orders#query_order_status", :as => "query_order"
          get "receive_order_status" => "orders#receive_order_status"

          get '/todolist' , action: 'index'
          get '/shipped' , action: 'shipped'
          get '/pending' , action: 'pending'
          get '/human_involved' , action: 'human_involved'
          #get '/history' , action: 'history'
          match 'history' => 'orders#history', via: [:get, :post], as: :history
          
        end

      end

      resources :orderasks, :only => [:index, :update] do
        collection do 
          get 'history', action: 'history'
        end
      end
      resources :users , :only => [:index, :show] do 
        collection do 
          get 'export', action: 'export'
          #get 'search', action: 'search'
        end
      end
      resources :deliveries

      delete 'peditor/deletePhoto/:id'        => 'peditor#destroyPhoto'
        
    

    #get '/camaadministrator/login' => 'devise/sessions#new'
    #unauthenticated :admin do
      #root to: redirect('/camaadministrator/login'), as: 'unauthenticated_root' # => "devise/sessions#new"
    #end
    
  end

  get '(*url)'   => 'errors#index'

end