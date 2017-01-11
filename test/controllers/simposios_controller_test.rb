require 'test_helper'

class SimposiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @simposio = simposios(:one)
  end

  test "should get index" do
    get simposios_url
    assert_response :success
  end

  test "should get new" do
    get new_simposio_url
    assert_response :success
  end

  test "should create simposio" do
    assert_difference('Simposio.count') do
      post simposios_url, params: { simposio: { conteudo: @simposio.conteudo, picture: @simposio.picture, titulo: @simposio.titulo, video: @simposio.video } }
    end

    assert_redirected_to simposio_url(Simposio.last)
  end

  test "should show simposio" do
    get simposio_url(@simposio)
    assert_response :success
  end

  test "should get edit" do
    get edit_simposio_url(@simposio)
    assert_response :success
  end

  test "should update simposio" do
    patch simposio_url(@simposio), params: { simposio: { conteudo: @simposio.conteudo, picture: @simposio.picture, titulo: @simposio.titulo, video: @simposio.video } }
    assert_redirected_to simposio_url(@simposio)
  end

  test "should destroy simposio" do
    assert_difference('Simposio.count', -1) do
      delete simposio_url(@simposio)
    end

    assert_redirected_to simposios_url
  end
end
