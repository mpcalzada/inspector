require "application_system_test_case"

class EmployersTest < ApplicationSystemTestCase
  setup do
    @employer = employers(:one)
  end

  test "visiting the index" do
    visit employers_url
    assert_selector "h1", text: "Employers"
  end

  test "creating a Employer" do
    visit employers_url
    click_on "New Employer"

    fill_in "Birthday", with: @employer.birthday
    fill_in "City", with: @employer.city
    fill_in "Contract number", with: @employer.contract_number
    fill_in "Country", with: @employer.country
    fill_in "Cp", with: @employer.cp
    fill_in "Email", with: @employer.email
    fill_in "First name", with: @employer.first_name
    fill_in "Last name", with: @employer.last_name
    fill_in "Phone number", with: @employer.phone_number
    fill_in "Rfc", with: @employer.rfc
    fill_in "Salary", with: @employer.salary
    fill_in "State", with: @employer.state
    fill_in "Street", with: @employer.street
    click_on "Create Employer"

    assert_text "Employer was successfully created"
    click_on "Back"
  end

  test "updating a Employer" do
    visit employers_url
    click_on "Edit", match: :first

    fill_in "Birthday", with: @employer.birthday
    fill_in "City", with: @employer.city
    fill_in "Contract number", with: @employer.contract_number
    fill_in "Country", with: @employer.country
    fill_in "Cp", with: @employer.cp
    fill_in "Email", with: @employer.email
    fill_in "First name", with: @employer.first_name
    fill_in "Last name", with: @employer.last_name
    fill_in "Phone number", with: @employer.phone_number
    fill_in "Rfc", with: @employer.rfc
    fill_in "Salary", with: @employer.salary
    fill_in "State", with: @employer.state
    fill_in "Street", with: @employer.street
    click_on "Update Employer"

    assert_text "Employer was successfully updated"
    click_on "Back"
  end

  test "destroying a Employer" do
    visit employers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employer was successfully destroyed"
  end
end
