require "application_system_test_case"

class Api::V1::ItemsTest < ApplicationSystemTestCase
  setup do
    @api_v1_item = api_v1_items(:one)
  end

  test "visiting the index" do
    visit api_v1_items_url
    assert_selector "h1", text: "Api/V1/Items"
  end

  test "creating a Item" do
    visit api_v1_items_url
    click_on "New Api/V1/Item"

    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit api_v1_items_url
    click_on "Edit", match: :first

    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit api_v1_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
