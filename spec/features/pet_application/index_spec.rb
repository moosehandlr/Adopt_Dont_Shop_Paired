require "rails_helper"

RSpec.describe "Pet Application Index Spec" do

  before :each do
    @placeholder_image = "generic-image-placeholder.png"
    # @image_name = @placeholder_image[0...-4]

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

    @catto = Pet.create(image: @placeholder_image,
      name: "Catto",
      approximate_age: 7,
      sex: "F",
      shelter: @shelter1,
      description: "What a cute animal!",
      status: "Adoptable")

    @application1 = Application.create!(name: "Billy Joel",
      address: "22 Jump Street",
      city: "Denver",
      state: "CO",
      zip: "80808",
      phone_number: "000000000",
      description: "Famous and rich")

    @application2 = Application.create!(name: "Joel Billy",
      address: "22 Jump Street",
      city: "Denver",
      state: "CO",
      zip: "80808",
      phone_number: "000000000",
      description: "Rich and famous")

    PetApplication.create!(pet_id: @catto.id, application_id: @application1.id )
    PetApplication.create!(pet_id: @catto.id, application_id: @application2.id )
  end

  describe "When I have favorited pets and applied for them" do
    describe "When I visit a pet's show page" do
      it "There is a link to view all applications for this pet" do
        visit "/pets/#{@catto.id}"

        expect(page).to have_link("All applications for #{@catto.name}", href: "/pets/#{@catto.id}/applications")
      end

      it "I see a page with all the applicants names and their names are links to their application" do
        visit "/pets/#{@catto.id}"

        click_link "All applications for #{@catto.name}"

        expect(page).to have_link(@application1.name, href: "/applications/#{@application1.id}")
        expect(page).to have_link(@application2.name, href: "/applications/#{@application2.id}")
      end
    end
  end

  describe "When I visit a pet applications index page for a pet that has no applications on them" do
    it "I see a message saying that there are no applications for this pet yet" do
      visit "/pets/#{@doggo.id}"

      click_link "All applications for #{@doggo.name}"

      expect(page).to have_content("There are no applications for this pet yet")
    end
  end
end
