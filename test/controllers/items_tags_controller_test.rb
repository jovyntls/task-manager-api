require 'test_helper'

class ItemsTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @items_tag = items_tags(:one)
  end

  test "should get index" do
    get items_tags_url, as: :json
    assert_response :success
  end

  test "should create items_tag" do
    assert_difference('ItemsTag.count') do
      post items_tags_url, params: { items_tag: { cat_id: @items_tag.cat_id, tag_id: @items_tag.tag_id } }, as: :json
    end

    assert_response 201
  end

  test "should show items_tag" do
    get items_tag_url(@items_tag), as: :json
    assert_response :success
  end

  test "should update items_tag" do
    patch items_tag_url(@items_tag), params: { items_tag: { cat_id: @items_tag.cat_id, tag_id: @items_tag.tag_id } }, as: :json
    assert_response 200
  end

  test "should destroy items_tag" do
    assert_difference('ItemsTag.count', -1) do
      delete items_tag_url(@items_tag), as: :json
    end

    assert_response 204
  end
end
