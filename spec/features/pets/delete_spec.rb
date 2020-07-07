require "rails_helper"

describe "Pet Delete" do
  describe "As a visitor" do
    describe "When I visit a pet show page" do
      it "I can delete a pet" do
        placeholder_image = "generic-image-placeholder.png"

        doggo_house = Shelter.create(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        doggo = Pet.create(
          image: placeholder_image,
          name: "Doggo",
          approximate_age: 3,
          sex: "M",
          shelter: doggo_house,
          description: "What a cute animal!",
          status: "Adoptable"
        )

        show_page = "/pets/#{doggo.id}"

        visit show_page

        click_link "Delete Pet"

        expect(current_path).to eq("/pets")

        expect(page).not_to have_text(doggo.name)
      end
    end
  end
end
