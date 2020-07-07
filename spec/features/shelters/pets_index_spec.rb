require "rails_helper"

describe "Shelter Pets Index" do
  describe "As a Visitor" do
    describe "When I visit '/shelters/:shelter_id/pets'" do
      it "I see each Pet that can be adopted from that Shelter" do
        lizzo_house = Shelter.create(name: "Lizzo House", address: "5125 E. Book Cir", city: "Denver", state: "CO", zip: "000000")
        id = lizzo_house.id

        placeholder_image = "generic-image-placeholder.png"
        image_name = placeholder_image[0...-4]

        loggo = Pet.create(image: placeholder_image, name: "Loggo", approximate_age: 3, sex: "M", shelter: lizzo_house, description: "What a cute animal!", status: "Adoptable")
        latto = Pet.create(image: placeholder_image, name: "Latto", approximate_age: 7, sex: "F", shelter: lizzo_house, description: "What a cute animal!", status: "Adoptable")

        visit "/shelters/#{id}/pets"

        expect(page).to have_text("All Pets at #{lizzo_house.name}:")

        loggo_image = find("#loggo-image")
        expect(loggo_image[:src]).to include(image_name)
        expect(loggo_image[:alt]).to eq("#{loggo.name}'s photo.")

        expect(page).to have_text("Name: #{loggo.name}")
        expect(page).to have_text("Age: #{loggo.approximate_age}")
        expect(page).to have_text("Sex: #{loggo.sex}")

        latto_image = find("#latto-image")
        expect(latto_image[:src]).to include(image_name)
        expect(latto_image[:alt]).to eq("#{latto.name}'s photo.")

        expect(page).to have_text("Name: #{latto.name}")
        expect(page).to have_text("Age: #{latto.approximate_age}")
        expect(page).to have_text("Sex: #{latto.sex}")
      end
    end
  end
end
