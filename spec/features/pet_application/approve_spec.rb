require "rails_helper"

RSpec.describe "Approving an Application Spec" do
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

    @pets = [@doggo, @catto]

    @billy_joel = Application.create!(name: "Billy Joel",
      address: "22 Jump Street",
      city: "Denver",
      state: "CO",
      zip: "80808",
      phone_number: "000000000",
      description: "Famous and rich")

    @prince = Application.create!(name: "Prince",
      address: "22 Jump Street",
      city: "Denver",
      state: "CO",
      zip: "80808",
      phone_number: "000000000",
      description: "Rich and famous")

    PetApplication.create!(pet_id: @doggo.id, application_id: @billy_joel.id )

    PetApplication.create!(pet_id: @doggo.id, application_id: @prince.id )
    PetApplication.create!(pet_id: @catto.id, application_id: @prince.id )
  end

  describe "As a visitor" do
    describe "When I visit an application's show page" do
      it "I can approve the application for one particular pet" do

        visit "/applications/#{@billy_joel.id}"

        expect(page).to have_link("Approve Application for #{@doggo.name}",
          href: "/pet_applications/#{@billy_joel.id}/#{@doggo.id}")

        click_link "Approve Application for #{@doggo.name}"

        expect(current_path).to eq("/pets/#{@doggo.id}")

        expect(page).to have_content("Status: Pending")
        expect(page).to have_content("On hold for Billy Joel")
      end
    end
  end

  describe "Users can get approved to adopt more than one pet" do
    describe "When an application is made for more than one pet" do
      it "I am able to approve the application for any number of pets" do
        approve_cat_link = "Approve Application for #{@catto.name}"
        approve_dog_link = "Approve Application for #{@doggo.name}"

        visit "/applications/#{@prince.id}"
        expect(page).to have_link(approve_dog_link, href: "/pet_applications/#{@prince.id}/#{@doggo.id}")

        click_link approve_dog_link
        expect(current_path).to eq("/pets/#{@doggo.id}")

        visit "/applications/#{@prince.id}"
        expect(page).to have_link(approve_cat_link, href: "/pet_applications/#{@prince.id}/#{@catto.id}")

        click_link approve_cat_link
        expect(current_path).to eq("/pets/#{@catto.id}")
      end
    end
  end

  describe "Pets can only have one approved application on them at any time" do
    it "I can not approve any other applications for a pet_app that has been approved" do
      approve_dog_link = "Approve Application for #{@doggo.name}"

      visit "/applications/#{@prince.id}"
      click_link approve_dog_link

      visit "/pets/#{@doggo.id}/applications"
      expect(page).to have_link(@prince.name, href: "/applications/#{@prince.id}")
      expect(page).to have_link(@billy_joel.name, href: "/applications/#{@billy_joel.id}")

      visit "/applications/#{@prince.id}"
      expect(page).to_not have_link("Approve Application for #{@doggo.name}",
        href: "/pet_applications/#{@prince.id}/#{@doggo.id}")

      visit "/applications/#{@billy_joel.id}"
      expect(page).to_not have_link("Approve Application for #{@doggo.name}",
        href: "/pet_applications/#{@billy_joel.id}/#{@doggo.id}")
    end
  end

  describe "Revoking approved applications" do
    it "can un-approve a pet application" do
      approve_dog_link = "Approve Application for #{@doggo.name}"
      unapprove_dog_link = "Unapprove Application for #{@doggo.name}"
      application_show_page = "/applications/#{@prince.id}"

      visit application_show_page
      click_link approve_dog_link

      visit application_show_page
      expect(page).to_not have_link(approve_dog_link)

      expect(page).to have_link("Unapprove Application for #{@doggo.name}",
        href: "/pet_applications/#{@prince.id}/#{@doggo.id}/unapprove")

      click_link unapprove_dog_link

      expect(current_path).to eq(application_show_page)
      expect(page).to have_link(approve_dog_link)

      visit "/pets/#{@doggo.id}"

      expect(page).to have_content("Status: Adoptable")
      expect(page).to_not have_content("On hold for Prince")
    end
  end
end
