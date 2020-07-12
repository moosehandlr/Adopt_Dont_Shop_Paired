require 'rails_helper'

RSpec.describe "Pet favorites spec" do
  before :each do
    @placeholder_image = "generic-image-placeholder.png"
    @image_name = @placeholder_image[0...-4]

    @shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
    @doggo = Pet.create(
      image: @placeholder_image,
      name: "Doggo",
      approximate_age: 3,
      sex: "M",
      shelter: @shelter1,
      description: "What a cute animal!",
      status: "Adoptable"
    )
  end

  it "Has favorite indicator in my navigation bar" do
    visit "/"
     within(".navbar") do
       expect(page).to have_content("Favorites: 0")
    end
  end

  describe "When I visit a pet's show page"
    it "I can favorite a pet" do
      visit "/pets/#{@doggo.id}"

      within(".navbar") do
        expect(page).to have_content("Favorites: 0")
      end

      click_button "Add Pet to Favorites"

      expect(current_path).to eq("/pets/#{@doggo.id}")

      expect(page).to have_content("You have added #{@doggo.name} to your favorites.")

      within(".navbar") do
        expect(page).to have_content("Favorites: 1")
      end
    end

end
