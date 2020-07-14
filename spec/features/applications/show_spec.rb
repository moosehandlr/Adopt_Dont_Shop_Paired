require "rails_helper"

RSpec.describe "Applications Show Page Spec" do

  before :each do
    @placeholder_image = "generic-image-placeholder.png"
    # @image_name = @placeholder_image[0...-4]

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

    @application = Application.create!(name: "Billy Joel",
                                      address: "22 Jump Street",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80808",
                                      phone_number: "000000000",
                                      description: "Famous and rich")

    PetApplication.create!(pet_id: @pet1.id, application_id: @application.id )
    PetApplication.create!(pet_id: @pet2.id, application_id: @application.id )
  end

  describe "When I visit /applications/:id" do
    it "I can see the applicant details and pet names for that application" do
      visit "/applications/#{@application.id}"

      within(".application-details") do
        expect(page).to have_content("Billy Joel")
        expect(page).to have_content("22 Jump Street")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content("80808")
        expect(page).to have_content("000000000")
        expect(page).to have_content("Famous and rich")
        expect(page).to have_link(@pet1.name, href: "/pets/#{@pet1.id}")
        expect(page).to have_link(@pet2.name, href: "/pets/#{@pet2.id}")
      end
    end
  end
end
