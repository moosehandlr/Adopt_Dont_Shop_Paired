require "rails_helper"

describe "Pet Links Spec" do
  describe "As a visitor to any page on the site" do
    describe "I can click a pet name to go the pet's show page" do
      before(:each) do
        @dog_shelter = Shelter.create(
          name: "Doggo House",
          address: "1323 Paper St",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @cat_shelter = Shelter.create(
          name: "Catto House",
          address: "2124 N. Pencil Ave",
          city: "Denver",
          state: "CO",
          zip: "000000"
        )

        @shelters = [@dog_shelter, @cat_shelter]

        placeholder_image = "generic-image-placeholder.png"
        @dog = Pet.create(
          image: placeholder_image,
          name: "Doggo",
          approximate_age: 3,
          sex: "M",
          shelter: @dog_shelter,
          description: "What a cute animal!",
          status: "Adoptable"
        )

        @cat = Pet.create(
          image: placeholder_image,
          name: "Catto",
          approximate_age: 7,
          sex: "F",
          shelter: @cat_shelter,
          description: "What a cute animal!",
          status: "Adoptable"
        )

        @pets = [@dog, @cat]
      end

      describe "The Pets Index page" do
        it "links to every pet" do
          @pets.each do |pet|
            visit "/pets"
            pet_show_page = "/pets/#{pet.id}"

            expect(page).to have_link(pet.name, href: pet_show_page)

            click_link pet.name
            expect(current_path).to eql(pet_show_page)
          end
        end
      end

      describe "A Shelter's Pets Index page" do
        it "links to every pet" do
          @shelters.each do |shelter|
            shelter_pets_index = "/shelters/#{shelter.id}/pets"
            shelter_pets = @pets.find_all { |pet| pet.shelter == shelter }
            visit shelter_pets_index

            shelter_pets.each do |pet|
              pet_show_page = "/pets/#{pet.id}"

              expect(page).to have_link(pet.name, href: pet_show_page)

              click_link pet.name
              expect(current_path).to eql(pet_show_page)
            end
          end
        end
      end

      describe "A Pet's Show page" do
        it "link to that pet" do
          @pets.each do |pet|
            pet_show_page = "/pets/#{pet.id}"
            visit pet_show_page

            expect(page).to have_link(pet.name, href: pet_show_page)

            click_link pet.name
            expect(current_path).to eql(pet_show_page)
          end
        end
      end
    end
  end
end
