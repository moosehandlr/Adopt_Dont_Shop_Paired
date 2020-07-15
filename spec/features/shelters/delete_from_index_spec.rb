require "rails_helper"

describe "Shelter Delete From Shelter Index Spec" do
  describe "As a visitor" do
    describe "When I visit the shelter index page" do
      it "I can find links to delete every shelter's information" do
        shelter1 = Shelter.create(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        shelter2 = Shelter.create(
          name: "Catto House",
          address: "2124 N. Pencil Ave",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        shelter3 = Shelter.create(
          name: "Lizzo House",
          address: "5125 E. Book Cir",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        shelter4 = Shelter.create(
          name: "Liono House",
          address: "6126 Library Blvd",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        shelters = Shelter.all

        visit "/shelters"
        shelters.each do |shelter|
          expect(page).to have_text(shelter.name)

          delete_link = "/shelters/#{shelter.id}"
          expect(page).to have_link("Delete Shelter", href: delete_link)
        end
      end

      it "I can delete a shelter and all reviews for that shelter are also deleted" do

        shelter1 = Shelter.create!(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000")

        review1 = Review.create!(
          title: "Review 1",
          rating: "4.5",
          content: "Clean with great customer service!",
          shelter_id: shelter1.id)

        review3 = Review.create!(
          title: "Review 3",
          rating: "4.6",
          content: "Great customer service and clean!",
          shelter_id: shelter1.id)

        visit "/shelters"

        click_link "Delete Shelter"
        expect(current_path).to eq("/shelters")

        expect(page).to_not have_content(shelter1.name)
        expect(page).to have_content("New Shelter")
      end

      it "If a shelter doesn't have any pets with a pending status I can delete that shelter" do

        placeholder_image = "generic-image-placeholder.png"

        shelter1 = Shelter.create!(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000")

        doggo = Pet.create!(
          image: placeholder_image,
          name: "Doggo",
          approximate_age: 3,
          sex: "M",
          shelter: shelter1,
          description: "What a cute animal!",
          status: "Adoptable"
        )

        application1 = Application.create!(name: "Billy Joel",
          address: "22 Jump Street",
          city: "Denver",
          state: "CO",
          zip: "80808",
          phone_number: "000000000",
          description: "Famous and rich")

        PetApplication.create!(pet_id: doggo.id, application_id: application1.id )


        visit "/shelters"

        click_link "Delete Shelter"
        expect(current_path).to eq("/shelters")

        expect(page).to_not have_content("Doggo House")
        expect(page).to have_content("New Shelter")

        visit "/pets"

        expect(page).to_not have_content("Doggo")
      end
    end
  end
end
