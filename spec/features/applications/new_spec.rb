require "rails_helper"

RSpec.describe "New Pet Application Spec" do
  before :each do
    @placeholder_image = "generic-image-placeholder.png"

    @shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")

    @pet1 = Pet.create(image: @placeholder_image,
                        name: "Doggo",
                        approximate_age: 3,
                        sex: "M",
                        shelter: @shelter1,
                        description: "What a cute animal!",
                        status: "Adoptable")

    @pet2 = Pet.create(image: @placeholder_image,
                        name: "Catto",
                        approximate_age: 7,
                        sex: "F",
                        shelter: @shelter1,
                        description: "What a cute animal!",
                        status: "Adoptable")

    @pets = [@pet1, @pet2]
  end


  describe "As a visitor, after I add pets to my favorites page" do
    it "I can submit an application to adopt them" do
      @pets.each do |pet|
        visit "/pets/#{pet.id}"
        click_button "Add Pet to Favorites"
      end

      visit "/favorites"

      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      expect(page).to have_link("Adopt Pets", href: "/applications/new")

      click_link "Adopt Pets"

      page.check("select-catto")
      page.uncheck("select-catto")

      page.check("select-doggo")

      fill_in :name, with: ""
      fill_in :address, with: ""
      fill_in :city, with: ""
      fill_in :state, with: ""
      fill_in :zip, with: ""
      fill_in :phone_number, with: ""
      fill_in :description, with: ""

      click_button "Submit Application"

      expect(page).to have_content("Application successfully submitted!")
      expect(current_path).to eq("/favorites")

      expect(page).to_not have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
    end
  end
end
