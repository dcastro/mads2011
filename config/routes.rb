Mads2011::Application.routes.draw do
  
  get "users/what"
  
  get "comments/index"

  post "comments/create"

  delete "comments/destroy"

  post "suggestion_scenarios/run_test"
  
  get "implemented_steps/match"

  post "suggestion_scenarios/create"

  post "suggestion_scenarios/destroy"

  get "steps/show"

  get "scenarios/show"

  get "features/show"

  post "roles/create"

  post "roles/remove"

  post "roles/update"

  resources :projects
  
  post "projects/update_state"

=begin
  post "user/login"
  post "user/logout"
  get "user/home"
  get "user/show"
=end

  #resources :users
  controller :users do
    post "users/login"
    post "users/logout"
    get 'users/show/:id' => :show, :as => :users_show
    get 'users/new' => :new
    post 'users/create' => :create
    get 'users/dynamic_search'
  end
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'users#home', :as => 'home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
