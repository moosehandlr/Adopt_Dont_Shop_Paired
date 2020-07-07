require "rails_helper"

describe "Shelter Links" do
  describe "As a visitor to any page on the site" do
    describe "I can click a shelter name to go the shelter's show page" do
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

          @shelters = [@shelter1, @shelter2, @shelter3, @shelter4]

          placeholder_image = "generic-image-placeholder.png"
          @dog = Pet.create(
            image: placeholder_image,
            name: "Doggo",
            approximate_age: 3,
            sex: "M",
            shelter: @shelter1,
            description: "What a cute animal!",
            status: "Adoptable"
          )

          @cat = Pet.create(
            image: placeholder_image,
            name: "Catto",
            approximate_age: 7,
            sex: "F",
            shelter: @shelter2,
            description: "What a cute animal!",
            status: "Adoptable"
          )

          @pets = [@dog, @cat]
      end

      describe "The Shelter Index page" do
        it "has links to every shelter" do
          @shelters.each do |shelter|
            show_page = "/shelters/#{shelter.id}"

            visit "/shelters"
            expect(page).to have_link(shelter.name, href: show_page)

            click_link shelter.name
            expect(current_path).to eql(show_page)
          end
        end
      end

      describe "A Shelter's Pets Index page" do
        it "links to that shelter" do
          @shelters.each do |shelter|
            show_page = "/shelters/#{shelter.id}"

            visit "/shelters/#{shelter.id}/pets"
            expect(page).to have_link(shelter.name, href: show_page)

            click_link shelter.name
            expect(current_path).to eql(show_page)
          end
        end
      end

      describe "A Shelter's Show page" do
        it "links to that shelter" do
          @shelters.each do |shelter|
            show_page = "/shelters/#{shelter.id}"
            visit show_page

            expect(page).to have_link(shelter.name, href: show_page)

            click_link shelter.name
            expect(current_path).to eql(show_page)
          end
        end
      end

      describe "The Pets Index page" do
        it "links to the shelters of each pet" do
          @pets.each do |pet|
            shelter_name = pet.shelter.name
            shelter_show_page = "/shelters/#{pet.shelter.id}"

            visit "/pets"
            expect(page).to have_link(shelter_name, href: shelter_show_page)

            click_link shelter_name
            expect(current_path).to eql(shelter_show_page)
          end
        end
      end
    end
  end
end
