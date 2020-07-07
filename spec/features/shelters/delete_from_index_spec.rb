require "rails_helper"

describe "Shelter Delete From Shelter Index Spec" do
  describe "As a visitor" do
    describe "When I visit the shelter index page" do
      before(:each) do
        @shelter1 = Shelter.create(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelter2 = Shelter.create(
          name: "Catto House",
          address: "2124 N. Pencil Ave",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelter3 = Shelter.create(
          name: "Lizzo House",
          address: "5125 E. Book Cir",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelter4 = Shelter.create(
          name: "Liono House",
          address: "6126 Library Blvd",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelters = Shelter.all
      end

      it "I can find links to delete every shelter's information" do
        visit "/shelters"
        @shelters.each do |shelter|
          expect(page).to have_text(shelter.name)

          delete_link = "/shelters/#{shelter.id}"
          expect(page).to have_link("Delete Shelter", href: delete_link)
        end
      end

      it "I can delete a shelter and not see it on the index after deleting" do
        visit "/shelters"
        expect(page).to have_text("Doggo House")

        delete_link = "/shelters/#{@shelter1.id}"
        click_link("Delete Shelter", href: delete_link)

        expect(current_path).to eql("/shelters")
        expect(page).to_not have_text("Doggo House")
      end
    end
  end
end
