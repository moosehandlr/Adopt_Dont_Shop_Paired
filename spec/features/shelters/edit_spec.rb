require "rails_helper"

describe "Shelter Update Spec" do
  describe "As a visitor" do
    describe "when I visit a shelter show page" do
      it "I can edit all of a shelter's information" do
        liono_house = Shelter.create(name: "Liono House", address: "6126 Library Blvd", city: "Denver", state: "CO", zip: "000000")
        id = liono_house.id

        visit "/shelters/#{id}"

        click_link "Update Shelter"

        expect(current_path).to eq("/shelters/#{id}/edit")

        fill_in "Name", with: "The Liono House"
        fill_in "Address", with: "57799 Lamp Post Road"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zip", with: "00000"

        click_on "Update Shelter"

        expect(current_path).to eq("/shelters")
        expect(page).to have_text("The Liono House")
      end

      it "I submit incomplete form and a flash message indicates which field(s) I am missing" do
        tigre_house = Shelter.create(name: "Tigre House", address: "6126 Library Blvd", city: "Denver", state: "CO", zip: "000000")
        id = tigre_house.id

        visit "/shelters/#{id}"

        click_link "Update Shelter"

        expect(current_path).to eq("/shelters/#{id}/edit")

        fill_in "Name", with: ""
        fill_in "City", with: "Boulder"
        fill_in "Zip", with: ""

        click_on "Update Shelter"

        expect(current_path).to eq("/shelters/#{id}/edit")
        expect(page).to have_text("Please add name, address, state, zip information before submitting.")
      end
    end
  end
end
