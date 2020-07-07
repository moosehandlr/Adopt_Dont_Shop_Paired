require "rails_helper"

describe "Shelter Index Link" do
  describe "When visiting any page on the site" do
    describe "There is a link to the Shelter Index" do
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

      # Pets pages
      describe "Pet index page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          visit shelter_index_page
          expect(page).to have_link(shelter_index_link, href: shelter_index_page)

          click_link shelter_index_link
          expect(current_path).to eql(shelter_index_page)
        end
      end

      describe "Pet edit page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          @pets.each do |pet|
            visit "/pets/#{pet.id}/edit"
            expect(page).to have_link(shelter_index_link, href: shelter_index_page)

            click_link shelter_index_link
            expect(current_path).to eql(shelter_index_page)
          end
        end
      end

      describe "Shelter Pets new page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          @shelters.each do |shelter|
            visit "/shelters/#{shelter.id}/pets/new"

            expect(page).to have_link(shelter_index_link, href: shelter_index_page)

            click_link shelter_index_link
            expect(current_path).to eql(shelter_index_page)
          end
        end
      end

      describe "Pet show page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          @pets.each do |pet|
            visit "/pets/#{pet.id}"
            expect(page).to have_link(shelter_index_link, href: shelter_index_page)

            click_link shelter_index_link
            expect(current_path).to eql(shelter_index_page)
          end
        end
      end

      # Shelters pages
      describe "Shelter index page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          visit "/shelters"
          expect(page).to have_link(shelter_index_link, href: shelter_index_page)

          click_link shelter_index_link
          expect(current_path).to eql(shelter_index_page)
        end
      end

      describe "Shelter edit page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          @shelters.each do |shelter|
            visit "/shelters/#{shelter.id}/edit"
            expect(page).to have_link(shelter_index_link, href: shelter_index_page)

            click_link shelter_index_link
            expect(current_path).to eql(shelter_index_page)
          end
        end
      end

      describe "Shelter new page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          visit "/shelters/new"
          expect(page).to have_link(shelter_index_link, href: shelter_index_page)

          click_link shelter_index_link
          expect(current_path).to eql(shelter_index_page)
        end
      end

      describe "Shelter show page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          @shelters.each do |shelter|
            visit "/shelters/#{shelter.id}"
            expect(page).to have_link(shelter_index_link, href: shelter_index_page)

            click_link shelter_index_link
            expect(current_path).to eql(shelter_index_page)
          end
        end
      end

      describe "Shelter Pets Index page" do
        it "Has a link to shelter index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          @shelters.each do |shelter|
            visit "/shelters/#{shelter.id}/pets"
            expect(page).to have_link(shelter_index_link, href: shelter_index_page)

            click_link shelter_index_link
            expect(current_path).to eql(shelter_index_page)
          end
        end
      end

      describe "Welcome page" do
        it "Has a link to pet index" do
          shelter_index_page = "/shelters"
          shelter_index_link = "Shelter Index"

          visit "/"
          expect(page).to have_link(shelter_index_link, href: shelter_index_page)

          click_link shelter_index_link
          expect(current_path).to eql(shelter_index_page)
        end
      end

    end
  end
end
