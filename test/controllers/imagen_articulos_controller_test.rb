require 'test_helper'

class ImagenArticulosControllerTest < ActionController::TestCase
  setup do
    @imagen_articulo = imagen_articulos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imagen_articulos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imagen_articulo" do
    assert_difference('ImagenArticulo.count') do
      post :create, imagen_articulo: { imagen: @imagen_articulo.imagen, laboratorio_id: @imagen_articulo.laboratorio_id, modelo_articulo: @imagen_articulo.modelo_articulo, nombre_articulo: @imagen_articulo.nombre_articulo, tipo_articulo: @imagen_articulo.tipo_articulo }
    end

    assert_redirected_to imagen_articulo_path(assigns(:imagen_articulo))
  end

  test "should show imagen_articulo" do
    get :show, id: @imagen_articulo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imagen_articulo
    assert_response :success
  end

  test "should update imagen_articulo" do
    patch :update, id: @imagen_articulo, imagen_articulo: { imagen: @imagen_articulo.imagen, laboratorio_id: @imagen_articulo.laboratorio_id, modelo_articulo: @imagen_articulo.modelo_articulo, nombre_articulo: @imagen_articulo.nombre_articulo, tipo_articulo: @imagen_articulo.tipo_articulo }
    assert_redirected_to imagen_articulo_path(assigns(:imagen_articulo))
  end

  test "should destroy imagen_articulo" do
    assert_difference('ImagenArticulo.count', -1) do
      delete :destroy, id: @imagen_articulo
    end

    assert_redirected_to imagen_articulos_path
  end
end
