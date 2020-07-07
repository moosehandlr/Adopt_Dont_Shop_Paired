require "rails_helper"

describe "Pet Show Spec" do
  describe "As a visitor" do
    describe "When I visit '/pets/:id'" do
      it "I see that pet and its details" do
        placeholder_image = "generic-image-placeholder.png"
        image_name = placeholder_image[0...-4]

        doggo_house = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
        doggo = Pet.create(image: placeholder_image, name: "Doggo", approximate_age: 3, sex: "M", shelter: doggo_house, description: "What a cute animal!", status: "Adoptable")
        id = doggo.id

        visit "/pets/#{id}"

        doggo_image = find("#doggo-image")
        expect(doggo_image[:src]).to include(image_name)
        expect(doggo_image[:alt]).to eq("Photo of #{doggo.name}.")

        expect(page).to have_text("Name: #{doggo.name}")
        expect(page).to have_text("Description: #{doggo.description}")
        expect(page).to have_text("Age: #{doggo.approximate_age}")
        expect(page).to have_text("Sex: #{doggo.sex}")
        expect(page).to have_text("Status: #{doggo.status}")
      end
    end
  end
end
