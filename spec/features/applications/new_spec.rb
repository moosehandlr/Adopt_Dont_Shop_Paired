require "rails_helper"

RSpec.describe "New Pet Application Spec" do
  before :each do
    @placeholder_image = "generic-image-placeholder.png"
    @image_name = @placeholder_image[0...-4]

    @shelter1 = Shelter.create(name: "Doggo House",
                               address: "1323 Paper St",
                               city: "Denver",
                               state: "CO",
                               zip: "000000")

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

    @pets.each do |pet|
      visit "/pets/#{pet.id}"
      click_button "Add Pet to Favorites"

      visit "/favorites"
    end
  end


  describe "As a visitor, after I add pets to my favorites page" do
    it "I can submit an application to adopt them" do

      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      expect(page).to have_link("Adopt Pets", href: "/applications/new")

      click_link "Adopt Pets"

      page.check("select-catto")
      page.uncheck("select-catto")
      
      page.check("select-doggo")

      fill_in :name, with: "Billy Joel"
      fill_in :address, with: "22 Jump Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80808"
      fill_in :phone_number, with: "000000000"
      fill_in :description, with: "Famous and rich"

      click_button "Submit Application"

      expect(page).to have_content("Application successfully submitted!")
      expect(current_path).to eq("/favorites")

      within("#favorite-pets") do
        expect(page).to have_content(@pet2.name)
        catto_image = find("#catto-image")
        expect(catto_image[:src]).to include(@image_name)
        expect(catto_image[:alt]).to eq("#{@pet2.name}'s photo.")
      end

      within("#pending-pets") do
        expect(page).to have_content(@pet1.name)
      end
    end
  end

  describe "When I fail to fill out the form completely" do
    it "I'm redirected back to the form and I see a flash message indicating to complete the necessary fields" do

      click_link "Adopt Pets"

      page.check("select-catto")

      page.check("select-doggo")

      fill_in :name, with: ""
      fill_in :address, with: ""
      fill_in :city, with: ""
      fill_in :state, with: ""
      fill_in :zip, with: ""
      fill_in :phone_number, with: ""
      fill_in :description, with: ""

      click_button "Submit Application"

      expect(page).to_not have_content("Application successfully submitted!")
      expect(page).to have_content("Form must be completed and pets selected in order to submit the application.")
      expect(current_path).to eq("/applications/new")
    end

    it "I cannot submit application without selecting pets" do

      click_link "Adopt Pets"

      page.uncheck("select-catto")

      page.uncheck("select-doggo")

      fill_in :name, with: "Billy Joel"
      fill_in :address, with: "22 Jump Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80808"
      fill_in :phone_number, with: "000000000"
      fill_in :description, with: "Famous and rich"

      click_button "Submit Application"

      expect(page).to_not have_content("Application successfully submitted!")
      expect(page).to have_content("Form must be completed and pets selected in order to submit the application.")
      expect(current_path).to eq("/applications/new")

    end
  end
end
