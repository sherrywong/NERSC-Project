NerscProject::Application.routes.draw do
  get "home/index"

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

  root :to => 'user#login'
  match "/user/login" => 'user#login'
  match "/user/index" => 'user#index'
  match "/user/destroy" => 'user#destroy', :as => :destroy_user
  match "/user/show_users" => 'user#show_users'
  match "/user/new" => 'user#new'
  match "/user/project/index" => 'project#index'
  match "/user/project/new" => 'project#new'
  match "/user/project/:pid/edit" => 'project#edit'
  match "/project/:pid/add_members" => 'project#add_members'
  match "/user/logout" => 'user#logout'
  match "/user/:id/edit" => 'user#edit', :as => :edit_user
  match "/user/update" => 'user#update', :as => :update_user
  match "/project/new" => 'project#new'
  #match "/project/login" => 'user#login'
  #match "/project/logout" => 'user#logout'
  #match "/risk/login" => 'user#login'
  #match "/risk/logout" => 'user#logout'
  match "/user/risk/index" => 'risk#index'
  match "/project/:pid/edit" => 'project#edit', :as => :edit_project
  match "/project/:pid/update" => 'project#update', :as => :update_project
  match "/user/project/:pid/risk/new" => 'risk#new', :as => :new_risk
  match "/user/project/:pid/risk/:rid/edit" => 'risk#edit', :as => :edit_risk
  match "/user/project/:pid/risk/:rid/update" => 'risk#update', :as => :update_risk
  match "/user/project/:pid/risk/index" => 'risk#index', :as => :risk_index
  match "/project/destroy" => 'project#destroy'
  match "/project/:pid/remove_member" => 'project#remove_member', :as => :remove_member
  match "/project/:pid/risk/destroy" => 'risk#destroy', :as => :destroy_risk


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
