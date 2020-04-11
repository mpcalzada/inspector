require "application_system_test_case"

class DegreesTest < ApplicationSystemTestCase
  setup do
    @degree = degrees(:one)
  end

  test "visiting the index" do
    visit degrees_url
    assert_selector "h1", text: "Degrees"
  end

  test "creating a Degree" do
    visit degrees_url
    click_on "New Degree"

    fill_in "Description", with: @degree.description
    click_on "Create Degree"

    assert_text "Degree was successfully created"
    click_on "Back"
  end

  test "updating a Degree" do
    visit degrees_url
    click_on "Edit", match: :first

    fill_in "Description", with: @degree.description
    click_on "Update Degree"

    assert_text "Degree was successfully updated"
    click_on "Back"
  end

  test "destroying a Degree" do
    visit degrees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Degree was successfully destroyed"
  end
end
