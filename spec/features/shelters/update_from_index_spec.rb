require "rails_helper"

describe "Shelter Update From Shelter Index Spec" do
  describe "As a visitor" do
    describe "When I visit the shelter index page" do
      before(:each) do
        @shelter1 ||= Shelter.create(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelter2 ||= Shelter.create(
          name: "Catto House",
          address: "2124 N. Pencil Ave",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelter3 ||= Shelter.create(
          name: "Lizzo House",
          address: "5125 E. Book Cir",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelter4 ||= Shelter.create(
          name: "Liono House",
          address: "6126 Library Blvd",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelters ||= Shelter.all
      end

      it "I can find links to update every shelter's information" do
        visit "/shelters"
        @shelters.each do |shelter|
          expect(page).to have_text(shelter.name)

          update_link = "/shelters/#{shelter.id}/edit"
          expect(page).to have_link("Update Shelter", href: update_link)
        end
      end

      it "I can click the link to update the shelter information" do
        visit "/shelters"

        expect(page).to have_text("Doggo House")

        update = "Update Shelter"
        update_link = "/shelters/#{@shelter1.id}/edit"
        click_link(update, href: update_link)
        expect(current_path).to eql(update_link)

        fill_in :name, with: "Canine Orphanage"
        click_button update

        expect(current_path).to eql("/shelters")

        expect(page).to_not have_text("Doggo House")
        expect(page).to have_text("Canine Orphanage")
      end
    end
  end
end
