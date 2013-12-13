Kzs::Application.routes.draw do


  get "/users/sign_out" => "sessions#destroy"
  devise_for :users

  mount Ckeditor::Engine => '/ckeditor'
  
  match '/documents/batch' => 'documents#batch'

  resources :documents do
    collection do
      get 'sents'
      get 'drafts'
      get 'callbacks'
    end
    member do
      get 'prepare'
      get 'approve'
      get 'callback'
      get 'archive'
      get 'delete'
      get 'send_document'
      get 'execute'
      get 'copy'
      get 'to_drafts'
      get 'reply'
    end
  end
  
  match '/document/executor_phone' => 'documents#executor_phone'
  
  resources :permits do
    member do
      get 'agree'
      get 'cancel'
      get 'release'
      get 'issue'
      get 'reject'
    end
    collection do
      get 'group_print'
    end
  end
  
  resources :statements do
    collection do
      get 'drafts'
    end
    member do 
      get 'prepare'
      get 'approve'
      get 'accept'
      get 'refuse'
      get 'send_statement'
      get 'task_list'
    end
  end
  
  resources :tasks do
    member do 
      get 'execute'
    end
  end
  


  resources :users, :controller => "users"
  resources :rights
  resources :groups
  resources :organizations
  resources :projects
  resources :document_attachments
  resources :task_lists
  

  root :to => 'dashboard#index'
  
  match '/active_admin' => 'admin/users#index'
  
  ActiveAdmin.routes(self)

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
