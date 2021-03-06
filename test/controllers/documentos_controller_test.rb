require 'test_helper'

class DocumentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @documento = documentos(:one)
  end

  test "should get index" do
    get documentos_url
    assert_response :success
  end

  test "should get new" do
    get new_documento_url
    assert_response :success
  end

  test "should create documento" do
    assert_difference('Documento.count') do
      post documentos_url, params: { documento: { data_defesa: @documento.data_defesa, descricao: @documento.descricao, mestrado: @documento.mestrado, status: @documento.status, tese: @documento.tese, titulo: @documento.titulo, user_id: @documento.user_id } }
    end

    assert_redirected_to documento_url(Documento.last)
  end

  test "should show documento" do
    get documento_url(@documento)
    assert_response :success
  end

  test "should get edit" do
    get edit_documento_url(@documento)
    assert_response :success
  end

  test "should update documento" do
    patch documento_url(@documento), params: { documento: { data_defesa: @documento.data_defesa, descricao: @documento.descricao, mestrado: @documento.mestrado, status: @documento.status, tese: @documento.tese, titulo: @documento.titulo, user_id: @documento.user_id } }
    assert_redirected_to documento_url(@documento)
  end

  test "should destroy documento" do
    assert_difference('Documento.count', -1) do
      delete documento_url(@documento)
    end

    assert_redirected_to documentos_url
  end
end
