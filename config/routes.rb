Rails.application.routes.draw do
  
  resources :categories
  resources :articles do
   resources :comments, only: [:create, :destroy, :update, :show]
  end
  
  devise_for :users
=begin
  get "/articles" index
  post "/articles" create
  delete "/articles/:id" delete
  get "/articles/:id" show
  get "/articles/new" new
  get "/articles/:id/edit" edit
  patch "/articles/:id" update
  put "/articles/:id" update
=end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'
  root 'articles#index'

  get "/dashboard", to: 'welcome#dashboard'

  get "/about", to: 'pages#about'
  get "/contact", to: 'pages#contact'

  put "/articles/:id/publish", to: "articles#publish"
  put "/articles/:id/unpublish", to: "articles#unpublish"

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