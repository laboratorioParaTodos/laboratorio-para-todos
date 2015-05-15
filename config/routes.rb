Rails.application.routes.draw do
  devise_for :usuarios, controllers: { registrations: "usuarios/registrations", sessions: "usuarios/sessions" }
  resources :imagen_articulos

  resources :imagen_laboratorios

  resources :materias


  resources :prestamos

  resources :usuario_prestamos

  resources :departamentos

  resources :carreras

  resources :articulos

  resources :laboratorios
  
  get 'prestamos/registrar/:laboratorio_id' => 'prestamos#new', as: :registrar_prestamo
  
  get 'articulos/laboratorio/:id' => 'articulos#index', as: :articulos_por_laboratorio
  
  get 'imagenes/laboratorios/:id' => 'imagen_laboratorios#index', as: :imagenes_por_laboratorio
  
  get 'articulos/agregar/:id_laboratorio' => 'articulos#new', as: :agregar_nuevo_articulo
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  get 'prestamos/laboratorio/:laboratorio_id' => 'prestamos#index', as: :prestamos_registrados
  
  get 'prestamos_abiertos/laboratorio/:laboratorio_id' => 'prestamos#prestamos_abiertos', as: :prestamos_abiertos
  # You can have the root of your site routed with "root"
  
  post 'prestamos/cerrar_prestamo/:id' => 'prestamos#cerrar_prestamo', as: :cerrar_prestamo
  
  get 'imagenes/articulos/:id' => 'imagen_articulos#new', as: :agregar_imagen_articulo
  
  post 'articulos/asignar_imagen/:id_articulo/:id_imagen' => 'articulos#asignar_imagen', as: :asignar_imagen_articulo
  
  get 'articulos/:id/grupo/:nombre/:modelo' => 'articulos#index', as: :articulos_por_grupo
  
  post 'articulos/agregar/prestamo/(:id)' => 'articulos#agregar_a_prestamo', as: :agregar_articulo_prestamo
  
  post 'articulos/eliminar/prestamo/:id_articulo' => 'articulos#eliminar_de_prestamo', as: :eliminar_articulo_prestamo
 
  post 'usuarios/prestamo/agregar/:categoria' => 'usuario_prestamos#new', as: :agregar_usuario_prestamo
  
  root 'laboratorios#index'
  
  

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
