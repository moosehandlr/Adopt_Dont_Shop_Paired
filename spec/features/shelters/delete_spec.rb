require "rails_helper"

describe "Shelter Delete Spec" do
  describe "As a visitor" do
    describe "When I visit a shelter show page" do
      it "I can delete that shelter" do
        catto_house = Shelter.create(name: "Catto House", address: "2124 N. Pencil Ave", city: "Denver", state: "CO", zip: "000000")
        liono_house = Shelter.create(name: "Liono House", address: "6126 Library Blvd", city: "Denver", state: "CO", zip: "000000")

        visit "/shelters/#{liono_house.id}"

        click_link "Delete Shelter"
        expect(current_path).to eq("/shelters")

        expect(page).to have_no_text(liono_house.name)
        expect(page).to have_text(catto_house.name)
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


        shelter2 = Shelter.create!(
          name: "Catto House",
          address: "2124 N. Pencil Ave",
          city: "Denver",
          state: "CO",
          zip: "000000")

        review2 = Review.create!(
          title: "Review 2",
          rating: "3.2",
          content: "No dogs. Just cats.",
          shelter_id: shelter2.id)

        visit "/shelters/#{shelter1.id}"

        click_link "Delete Shelter"
        expect(current_path).to eq("/shelters")

        expect(page).to_not have_content(shelter1.name)
        expect(page).to have_content(shelter2.name)
      end
    end
  end
end
