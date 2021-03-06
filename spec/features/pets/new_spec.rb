require "rails_helper"

describe "Shelter Pet Creation Spec" do
  describe "As a visitor" do
    describe "When I visit a Shelter Pets Index page" do
      it "I can create a new Pet" do
        liono_house = Shelter.create(
          name: "Liono House",
          address: "6126 Library Blvd",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        id = liono_house.id
        shelter_pets_index = "/shelters/#{id}/pets"

        image_placeholder = "https://www.webfx.com/blog/images/cdn.designinstruct.com/files/582-how-to-image-placeholders/generic-image-placeholder.png"

        visit shelter_pets_index

        click_link "Create Pet"

        expect(current_path).to eq("#{shelter_pets_index}/new")

        fill_in :image, with: image_placeholder
        fill_in "Name", with: "Liono"
        fill_in "Description", with: "What a ferociously cuddly lion!"
        fill_in :approximate_age, with: "80"
        fill_in "Sex", with: "male"

        click_button("Create Pet")

        expect(current_path).to eq("/shelters/#{id}/pets")

        liono_image = find("#liono-image")
        expect(liono_image[:src]).to include(image_placeholder)
        expect(liono_image[:alt]).to eq("Liono's photo.")

        expect(page).to have_text("Name: Liono")
        expect(page).to have_text("Age: 80")
        expect(page).to have_text("Sex: male")
      end

      it "I submit incomplete form and a flash message indicates which field(s) I am missing" do
        liono_house = Shelter.create(
          name: "Liono House",
          address: "6126 Library Blvd",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        image_placeholder = "https://www.webfx.com/blog/images/cdn.designinstruct.com/files/582-how-to-image-placeholders/generic-image-placeholder.png"

        visit "/shelters/#{liono_house.id}/pets"

        click_link "Create Pet"

        expect(current_path).to eql("/shelters/#{liono_house.id}/pets/new")

        fill_in :image, with: image_placeholder
        fill_in "Name", with: ""
        fill_in "Description", with: "What a ferociously cuddly lion!"
        fill_in :approximate_age, with: ""
        fill_in "Sex", with: "male"

        click_button("Create Pet")

        expect(current_path).to eq("/shelters/#{liono_house.id}/pets/new")

        expect(page).to have_text("Please add name, approximate_age information before submitting")
      end
    end
  end
end
