require 'test_helper'

class VideosSimposiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @videos_simposio = videos_simposios(:one)
  end

  test "should get index" do
    get videos_simposios_url
    assert_response :success
  end

  test "should get new" do
    get new_videos_simposio_url
    assert_response :success
  end

  test "should create videos_simposio" do
    assert_difference('VideosSimposio.count') do
      post videos_simposios_url, params: { videos_simposio: { simposio_id: @videos_simposio.simposio_id, video: @videos_simposio.video } }
    end

    assert_redirected_to videos_simposio_url(VideosSimposio.last)
  end

  test "should show videos_simposio" do
    get videos_simposio_url(@videos_simposio)
    assert_response :success
  end

  test "should get edit" do
    get edit_videos_simposio_url(@videos_simposio)
    assert_response :success
  end

  test "should update videos_simposio" do
    patch videos_simposio_url(@videos_simposio), params: { videos_simposio: { simposio_id: @videos_simposio.simposio_id, video: @videos_simposio.video } }
    assert_redirected_to videos_simposio_url(@videos_simposio)
  end

  test "should destroy videos_simposio" do
    assert_difference('VideosSimposio.count', -1) do
      delete videos_simposio_url(@videos_simposio)
    end

    assert_redirected_to videos_simposios_url
  end
end
