require 'rails_helper'

RSpec.describe "Pet favorites deletion spec" do
  before :each do
    @placeholder_image = "generic-image-placeholder.png"

    @shelter1 = Shelter.create(name: "Doggo House",
                               address: "1323 Paper St",
                               city: "Denver",
                               state: "CO",
                               zip: "000000")

    @doggo = Pet.create(image: @placeholder_image,
                        name: "Doggo",
                        approximate_age: 3,
                        sex: "M",
                        shelter: @shelter1,
                        description: "What a cute animal!",
                        status: "Adoptable")

    @dog_show_page = "/pets/#{@doggo.id}"
  end

  describe "As a visitor after I've favorited a pet" do
    describe "When I visit that pet's show page " do
      it "I no longer see a link to favorite that pet" do
        visit @dog_show_page
        expect(page).to have_content("Favorites: 0")
        expect(page).to have_button("Add Pet to Favorites")

        click_button "Add Pet to Favorites"
        expect(page).to have_content("Favorites: 1")

        expect(page).not_to have_button("Add Pet to Favorites")
        expect(page).to have_button("Remove Pet from Favorites")
      end

      it "I can delete a pet from my favorites" do
        visit @dog_show_page
        expect(page).to have_content("Favorites: 0")

        click_button "Add Pet to Favorites"
        expect(current_path).to eq(@dog_show_page)
        expect(page).to have_content("Favorites: 1")

        click_button "Remove Pet from Favorites"
        expect(current_path).to eq(@dog_show_page)

        expect(page).to have_content("#{@doggo.name} has been removed from your favorites")
        expect(page).to have_content("Favorites: 0")

        expect(page).to have_button("Add Pet to Favorites")
        expect(page).not_to have_button("Remove Pet from Favorites")
      end
    end

    describe "When I visit my favorites page" do
      it "I can remove a pet from my favorites" do
        visit @dog_show_page
        click_button "Add Pet to Favorites"
        expect(page).to have_content("Favorites: 1")

        visit "/favorites"
        expect(page).to have_button("Remove Pet from Favorites")

        click_button "Remove Pet from Favorites"
        expect(current_path).to eq("/favorites")

        expect(page).to_not have_link(@doggo.name)
        expect(page).to have_content("Favorites: 0")
      end

      it "I can remove all pets from my favorites" do
        visit @dog_show_page
        click_button "Add Pet to Favorites"
        expect(page).to have_content("Favorites: 1")

        visit "/favorites"
        expect(page).to have_link("Remove All Pets from Favorites")

        click_link "Remove All Pets from Favorites"
        expect(current_path).to eq("/favorites")

        expect(page).to have_content("You have no favorited pets")
        expect(page).to have_content("Favorites: 0")
      end
    end
  end
end
