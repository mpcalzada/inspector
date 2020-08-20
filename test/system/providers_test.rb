require "application_system_test_case"

class ProvidersTest < ApplicationSystemTestCase
  setup do
    @provider = providers(:one)
  end

  test "visiting the index" do
    visit providers_url
    assert_selector "h1", text: "Providers"
  end

  test "creating a Provider" do
    visit providers_url
    click_on "New Provider"

    fill_in "Address", with: @provider.address
    fill_in "City", with: @provider.city
    fill_in "Contact email", with: @provider.contact_email
    fill_in "Contact phone", with: @provider.contact_phone
    fill_in "Full name", with: @provider.full_name
    check "Is business entity" if @provider.is_business_entity
    click_on "Create Provider"

    assert_text "Provider was successfully created"
    click_on "Back"
  end

  test "updating a Provider" do
    visit providers_url
    click_on "Edit", match: :first

    fill_in "Address", with: @provider.address
    fill_in "City", with: @provider.city
    fill_in "Contact email", with: @provider.contact_email
    fill_in "Contact phone", with: @provider.contact_phone
    fill_in "Full name", with: @provider.full_name
    check "Is business entity" if @provider.is_business_entity
    click_on "Update Provider"

    assert_text "Provider was successfully updated"
    click_on "Back"
  end

  test "destroying a Provider" do
    visit providers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Provider was successfully destroyed"
  end
end
