# test/controllers/items_controller_test.rb
require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @item = items(:one)
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count", 1) do
      post items_url, params: {
        item: {
          name: "Test Item",
          price: 100,
          status: "draft",
          category: "cd",
          description: "test"   # ← 追加
        }
      }
      puts Item.last.errors.full_messages
    end
    assert_redirected_to item_path(Item.last)
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: {
      item: {
        name: "Updated Name",
        status: "draft",
        category: "cd",
        price: @item.price,
        description: "test"  # ← 追加
      }
    }    
    assert_redirected_to item_path(@item)
    @item.reload
    assert_equal "Updated Name", @item.name
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete item_url(@item)
    end
    assert_redirected_to items_url
  end

  test "should get dashboard" do
    get dashboard_items_path
    assert_response :success
  end
end
