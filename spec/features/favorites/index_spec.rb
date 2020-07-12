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

    @catto = Pet.create(
      image: @placeholder_image,
      name: "Catto",
      approximate_age: 7,
      sex: "F",
      shelter: @shelter1,
      description: "What a cute animal!",
      status: "Adoptable"
    )
  end

  describe "When I have added pets to my favorites list" do
    it "I see all pets I've favorited and their information" do

      visit "/pets/#{@doggo.id}"

      click_button "Add Pet to Favorites"

      visit "/pets/#{@catto.id}"

      click_button "Add Pet to Favorites"

      visit "/favorites"

      expect(page).to have_content(@doggo.name)
      expect(page).to have_link(@doggo.name, href: "/pets/#{@doggo.id}")

      doggo_image = find("#doggo-image")
      expect(doggo_image[:src]).to include(@image_name)
      expect(doggo_image[:alt]).to eq("#{@doggo.name}'s photo.")


      expect(page).to have_content(@catto.name)
      expect(page).to have_link(@catto.name, href: "/pets/#{@catto.id}")

      catto_image = find("#catto-image")
      expect(catto_image[:src]).to include(@image_name)
      expect(catto_image[:alt]).to eq("#{@catto.name}'s photo.")
    end
  end

  describe "When I click on the favorite indicator in the nav bar" do
    it "I am taken to the favorites index page" do
      visit "/"

      within(".navbar") do
        expect(page).to have_link("Favorites:", href: "/favorites")
        click_link "Favorites:"
      end

      expect(current_path).to eq("/favorites")
    end
  end
end
