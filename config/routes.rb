Feira3::Application.routes.draw do

  resources :contas

  resources :vendas do
    collection do
      get 'clientes'
      get 'comissionadas'
    end
    post 'edit', :on => :member 
    
    resources :itens, :controller => 'venda_itens'
  end

  resources :sacolas do 
    resources :itens, :controller => 'sacola_itens' do
      post 'devolve', :on => :collection 
    end
  end

  resources :vendedores
  resources :clientes


  resources :tamanhos

  resources :cores

  resources :itens

  resources :compras do
    resources :itens, :controller => 'compra_itens'
  end

  resources :produtos do
    post 'lucro', :on => :collection
  end 
  
  resources :fornecedores do
    post 'ativar', :on => :member 
  end
  
  resources :tipos
  resources :linhas
  resources :colecoes

  resources :registros

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
   root :to => "produtos#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
