ActionController::Routing::Routes.draw do |map|

  map.root :controller => "site"

  map.resources :users
  map.resources :folders, :member => {:add_new_entities => :get} do |folder|
    folder.resources :posts
  end

  map.settings '/settings/', :controller => "user_settings", :action => "edit"
  map.save_settings '/settings/save', :controller => "user_settings", :action => "update"

  # map.resources :entities do |post|
  #   post.resources :comments
  # end

  map.add_comment '/entity/:entity_type/:entity_id/comment', :controller => 'comments', :action => 'create', :method => :post

  map.sign_up '/sign_up', :controller => "users", :action => "new"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
