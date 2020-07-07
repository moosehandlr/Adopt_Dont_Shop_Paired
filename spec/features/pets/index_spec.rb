require "rails_helper"

describe "Pet Index Spec" do
  describe "As a visitor to '/pets'" do
    it "I can see each Pet's image, name, approx. age, sex, and shelter name" do
      placeholder_image = "generic-image-placeholder.png"
      image_name = placeholder_image[0...-4]

      doggo_house = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
      catto_house = Shelter.create(name: "Catto House", address: "2124 N. Pencil Ave", city: "Denver", state: "CO", zip: "000000")

      doggo = Pet.create(
        image: placeholder_image,
        name: "Doggo",
        approximate_age: 3,
        sex: "M",
        shelter: doggo_house,
        description: "What a cute animal!",
        status: "Adoptable"
      )

      catto = Pet.create(
        image: placeholder_image,
        name: "Catto",
        approximate_age: 7,
        sex: "F",
        shelter: catto_house,
        description: "What a cute animal!",
        status: "Adoptable"
      )

      visit "/pets"

      doggo_image = find("#doggo-image")
      expect(doggo_image[:src]).to include(image_name)
      expect(doggo_image[:alt]).to eq("#{doggo.name}'s photo.")

      expect(page).to have_text("Name: #{doggo.name}")
      expect(page).to have_text("Age: #{doggo.approximate_age}")
      expect(page).to have_text("Sex: #{doggo.sex}")
      expect(page).to have_text("Shelter: #{doggo_house.name}")

      catto_image = find("#catto-image")
      expect(catto_image[:src]).to include(image_name)
      expect(catto_image[:alt]).to eq("#{catto.name}'s photo.")

      expect(page).to have_text("Name: #{catto.name}")
      expect(page).to have_text("Age: #{catto.approximate_age}")
      expect(page).to have_text("Sex: #{catto.sex}")
      expect(page).to have_text("Shelter: #{catto_house.name}")

    end
  end
end
