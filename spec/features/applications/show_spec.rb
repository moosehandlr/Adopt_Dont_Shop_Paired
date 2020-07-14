require "rails_helper"

RSpec.describe "Applications Show Page Spec" do

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

    @pets.each do |pet|
      visit "/pets/#{pet.id}"
      click_button "Add Pet to Favorites"

      visit "/favorites"

      click_link "Adopt Pets"

      page.check("select-catto")
      page.check("select-doggo")

      fill_in :name, with: "Billy Joel"
      fill_in :address, with: "22 Jump Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80808"
      fill_in :phone_number, with: "000000000"
      fill_in :description, with: "Famous and rich"

      click_button "Submit Application"

    end

  describe "When I visit /applications/:id" do
    describe "" do
      it "" do
        # visit "/applications/#{applications.id}"
        # As a visitor
        # When I visit an applications show page "/applications/:id"
        # I can see the following:
        #
        # name
        # address
        # city
        # state
        # zip
        # phone number
        # Description of why the applicant says they'd be a good home for this pet(s)
        #
        # (all names of pets should be links to their show page)
        # names of all pet's that this application is for
      end
    end
  end
end

end
