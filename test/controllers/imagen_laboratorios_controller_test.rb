require 'test_helper'

class ImagenLaboratoriosControllerTest < ActionController::TestCase
  setup do
    @imagen_laboratorio = imagen_laboratorios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imagen_laboratorios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imagen_laboratorio" do
    assert_difference('ImagenLaboratorio.count') do
      post :create, imagen_laboratorio: { descripcion: @imagen_laboratorio.descripcion, imagen: @imagen_laboratorio.imagen, laboratorio_id: @imagen_laboratorio.laboratorio_id }
    end

    assert_redirected_to imagen_laboratorio_path(assigns(:imagen_laboratorio))
  end

  test "should show imagen_laboratorio" do
    get :show, id: @imagen_laboratorio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imagen_laboratorio
    assert_response :success
  end

  test "should update imagen_laboratorio" do
    patch :update, id: @imagen_laboratorio, imagen_laboratorio: { descripcion: @imagen_laboratorio.descripcion, imagen: @imagen_laboratorio.imagen, laboratorio_id: @imagen_laboratorio.laboratorio_id }
    assert_redirected_to imagen_laboratorio_path(assigns(:imagen_laboratorio))
  end

  test "should destroy imagen_laboratorio" do
    assert_difference('ImagenLaboratorio.count', -1) do
      delete :destroy, id: @imagen_laboratorio
    end

    assert_redirected_to imagen_laboratorios_path
  end
end
