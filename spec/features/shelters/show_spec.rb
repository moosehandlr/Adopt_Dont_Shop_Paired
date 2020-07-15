require "rails_helper.rb"

RSpec.describe "Shelter Show Page Spec" do
  describe "Visiting '/shelters/:id'" do
    it "displays that shelter's name, address, city, state, and zip" do
      doggo_house = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
      catto_house = Shelter.create(name: "Catto House", address: "2124 N. Pencil Ave", city: "Denver", state: "CO", zip: "000000")

      visit "/shelters/#{doggo_house.id}"

      expect(page).to have_text(doggo_house.name)
      expect(page).to have_text(doggo_house.address)
      expect(page).to have_text(doggo_house.city)
      expect(page).to have_text(doggo_house.state)
      expect(page).to have_text(doggo_house.zip)

      expect(page).to_not have_text(catto_house.name)
      expect(page).to_not have_text(catto_house.address)
    end
  end

  describe "Shelter Statistics" do
    it "I see statistics on a shelter's show page" do
      placeholder_image = "generic-image-placeholder.png"

      shelter1 = Shelter.create(name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000")

      review1 = Review.create!(
        title: "Review 1",
        rating: "5",
        content: "Clean with great customer service!",
        shelter_id: shelter1.id)

      review2 = Review.create!(
        title: "Review 2",
        rating: "4",
        content: "Great customer service and clean!",
        shelter_id: shelter1.id)

      pet1 = Pet.create(image: placeholder_image,
        name: "Doggo",
          approximate_age: 3,
          sex: "M",
          shelter: shelter1,
          description: "What a cute animal!",
          status: "Adoptable")

      pet2 = Pet.create(image: placeholder_image,
        name: "Catto",
        approximate_age: 7,
        sex: "F",
        shelter: shelter1,
        description: "What a cute animal!",
        status: "Adoptable")

      application = Application.create!(name: "Prince",
        address: "22 Jump Street",
        city: "Denver",
        state: "CO",
        zip: "80808",
        phone_number: "000000000",
        description: "Famous and rich")

      PetApplication.create!(pet_id: pet1.id, application_id: application.id )
      PetApplication.create!(pet_id: pet2.id, application_id: application.id )

      visit "shelters/#{shelter1.id}"

      expect(page).to have_content("Count of pets: 2")
      expect(page).to have_content("Average review: 4.5")
      expect(page).to have_content("Applications on file: 2")
    end
  end
end
