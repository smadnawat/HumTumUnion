Signup::Application.routes.draw do
 devise_for :users, :controllers => { :registrations => "registrations" }
  get "comments/new"
  get "sessions/new"
  get "users/new"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   
   resources :users do
    resources :articles
    resources :profiles
    resources :groups
    resources :datings
    resources :messages
  end

  resources :articles do 
    resources :comments
    resources :likes
  end

  get 'request_for_date' => "datings#request_for_date", as: 'request_for_date'
  get 'accept_date/:id/date/:date' => "datings#accept_date", :as => "accept_date"

  get 'like_it' => "likes#like_it", as: 'like_it'
  post 'add_comment' => "comments#add_comment", as: 'add_comment'

  get    'addadmin'   => 'admin#new'
  get    'adminshow/:id' => 'admin#show', as: 'adminshow' 
  get    'adminindex/:id'   =>  'admin#index', as: 'adminindex'
  post   'admincreate'   => 'admin#create'
  get    'all_groups/:id' => 'admin#all_groups', as: 'all_groups'
  delete 'current_user/:user_id/deleteuser/:id'  => 'admin#destroy', as: 'deleteuser'

  # get    'login'   => 'sessions#new'
   get    'show/:id' => 'sessions#show', as: 'show_request' 
   get    'index/:id'   =>  'sessions#index', as: 'index'
  # post   'login'   => 'sessions#create'
  # delete 'logout'  => 'sessions#destroy'
  get 'usertitle/:user_id/article/:id' => 'sessions#usertitle', as: 'usertitle'
  get 'find_friend/:id' => 'sessions#find_friend', :as => 'find_friend'
  get 'friendlist/:id' => 'sessions#friendlist', :as => 'friend_list'
  get 'user/:id/request_to/:friend_id' => 'sessions#send_request', :as => 'send_request'
  get 'user/:id/accept/:request_id' => 'sessions#accept_request', :as => 'accept_request'
  get 'user/:id/reject/:request_id' => 'sessions#reject_request', :as => 'reject_request'
  get 'user/:id/unfriend/:request_id'=> 'sessions#unfriend', :as => 'unfriend'
  get 'user/:id/blocks/:request_id' => 'sessions#block', :as => 'block'
  get 'user/:id/unblock/:request_id' => 'sessions#unblock', :as => 'unblock'
  get 'user/:id/block_list' => 'sessions#block_list', :as => 'block_list'
  get '/count_request/:id' => 'sessions#count_request', :as => '/count_request' 
  get '/update_feeds/:id' => 'likes#feeds', :as => '/update_feeds'
  get 'profile/:id/show' => 'profiles#show', :as => 'profile'
  get 'setting/:id' => 'users#setting', :as => 'setting'
  post 'update_password/:id' => 'users#update_password', :as => 'update_password'

  get 'add_group_member/:user_id/group/:group_id' => 'groups#add_group_member', :as => 'add_group_member'
  get 'add_member/:group_id/member/:member_id' => 'groups#add_member', :as => 'add_member'
  post 'group/:user_id/search_group' => 'groups#search_group',:as => 'search_group'
  get 'join_group/:user_id/group/:group_id' => 'groups#join_group',:as => 'join_group'
  get 'show_group/:user_id/group/:group_id' => 'groups#show_group',:as => 'show_group'
  post 'group/:user_id/search_person/:group_id' => 'groups#search_person',:as => 'search_person'

  get 'inbox/:id' => 'messages#inbox',:as => 'inbox'
  delete 'conversation/:id' => 'messages#delete_conversation',:as => 'delete_conversation'

  get "new_group_message/:sender/group/:id" => 'messages#new_group_message',:as => 'new_group_message'
  post'group_message/:sender/group/:id' => 'messages#group_message',:as =>'group_message' 
  post 'search_people' => 'sessions#search_people',:as => 'search_people'
  get 'sent_request' => 'sessions#sent_request',:as =>  'sent_request'
 
  # get '/update_inbox/:id' => 'messages#update_inbox',:as => '/update_inbox'
  #get 'create_group/:id' => 'groups#create_group',:as => 'create_group'

   root 'users#new'

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
