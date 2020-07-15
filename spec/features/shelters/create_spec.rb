require "rails_helper.rb"

describe "New Shelter Creation Spec" do
  it "Create a new shelter" do
    visit "/shelters"

    click_link "New Shelter"

    expect(current_path).to eql "/shelters/new"

    fill_in "Name", with: "Roboto House"
    fill_in "Address", with: "57799 Lamp Post Road"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "00000"
    click_button("Create Shelter")

    expect(current_path).to eql "/shelters"
    expect(page).to have_text("Roboto House")
  end

  it "I submit incomplete form and a flash message indicates which field(s) I am missing" do
    visit "/shelters"

    click_link "New Shelter"

    expect(current_path).to eql "/shelters/new"

    fill_in "Name", with: "Roboto House"
    fill_in "Address", with: "57799 Lamp Post Road"
    fill_in "City", with: ""
    fill_in "State", with: "CO"
    fill_in "Zip", with: ""
    click_button("Create Shelter")

    expect(current_path).to eql "/shelters/new"
    expect(page).to have_text("Please add city, zip information before submitting")
  end
end
