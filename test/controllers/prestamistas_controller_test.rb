require 'test_helper'

class PrestamistasControllerTest < ActionController::TestCase
  setup do
    @prestamista = prestamistas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prestamistas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prestamista" do
    assert_difference('Prestamista.count') do
      post :create, prestamista: { apellido_materno: @prestamista.apellido_materno, apellido_paterno: @prestamista.apellido_paterno, carrera_id: @prestamista.carrera_id, categoria: @prestamista.categoria, primer_nombre: @prestamista.primer_nombre, segundo_nombre: @prestamista.segundo_nombre }
    end

    assert_redirected_to prestamista_path(assigns(:prestamista))
  end

  test "should show prestamista" do
    get :show, id: @prestamista
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prestamista
    assert_response :success
  end

  test "should update prestamista" do
    patch :update, id: @prestamista, prestamista: { apellido_materno: @prestamista.apellido_materno, apellido_paterno: @prestamista.apellido_paterno, carrera_id: @prestamista.carrera_id, categoria: @prestamista.categoria, primer_nombre: @prestamista.primer_nombre, segundo_nombre: @prestamista.segundo_nombre }
    assert_redirected_to prestamista_path(assigns(:prestamista))
  end

  test "should destroy prestamista" do
    assert_difference('Prestamista.count', -1) do
      delete :destroy, id: @prestamista
    end

    assert_redirected_to prestamistas_path
  end
end
