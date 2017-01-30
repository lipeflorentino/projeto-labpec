require 'test_helper'

class DocumentosSimposiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @documentos_simposio = documentos_simposios(:one)
  end

  test "should get index" do
    get documentos_simposios_url
    assert_response :success
  end

  test "should get new" do
    get new_documentos_simposio_url
    assert_response :success
  end

  test "should create documentos_simposio" do
    assert_difference('DocumentosSimposio.count') do
      post documentos_simposios_url, params: { documentos_simposio: { arquivo: @documentos_simposio.arquivo, simposio_id: @documentos_simposio.simposio_id } }
    end

    assert_redirected_to documentos_simposio_url(DocumentosSimposio.last)
  end

  test "should show documentos_simposio" do
    get documentos_simposio_url(@documentos_simposio)
    assert_response :success
  end

  test "should get edit" do
    get edit_documentos_simposio_url(@documentos_simposio)
    assert_response :success
  end

  test "should update documentos_simposio" do
    patch documentos_simposio_url(@documentos_simposio), params: { documentos_simposio: { arquivo: @documentos_simposio.arquivo, simposio_id: @documentos_simposio.simposio_id } }
    assert_redirected_to documentos_simposio_url(@documentos_simposio)
  end

  test "should destroy documentos_simposio" do
    assert_difference('DocumentosSimposio.count', -1) do
      delete documentos_simposio_url(@documentos_simposio)
    end

    assert_redirected_to documentos_simposios_url
  end
end
