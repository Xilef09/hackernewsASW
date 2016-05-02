Rails.application.routes.draw do
  resources :replies
  resources :comments
  resources :contributions
  resources :users
  
  get 'comment/new'
  
  get 'static_pages/home'
  
  
    # You can have the root of your site routed with "root"
  root 'static_pages#home'
  
  
  resources :static_pages do
    resources :contributions
  end
  
  resources :users do
    member do
      get :contributions, :comments, :replies, :threads
    end
  end
  
  resources :contributions do
      resources :comments
  end
  
  resources :comments do
      resources :replies
  end
  
  
  resources :contributions do
  member do
      put "like", to: "contributions#upvote"
      #put "dislike", to: "contributions#downvote"
    end
  end
  
  resources :comments do
  member do
      put "like", to: "comments#upvote"
      #put "dislike", to: "comments#downvote"
    end
  end
  
  resources :replies do
  member do
      put "like", to: "replies#upvote"
      #put "dislike", to: "replies#downvote"
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  get 'home' => 'layouts#home'
  
  get 'login' => 'users#new'
  
  get 'contributions' => 'contributions#index'
  
  get 'asks' => 'asks#index'
  
  post '/replies' => 'replies#new'
  
  get '/auth/twitter/callback', to: 'sessions#create'
  
  delete '/sign_out', to: 'sessions#destroy'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
