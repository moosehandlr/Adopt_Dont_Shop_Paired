require "rails_helper"

RSpec.describe "Approved PetApps Prevent Deletions" do
  before :each do
    placeholder_image = "generic-image-placeholder.png"
    @shelter1 = Shelter.create(name: "Doggo House",
                              address: "1323 Paper St",
                              city: "Denver",
                              state: "CO",
                              zip: "000000")
    @doggo = Pet.create(image: placeholder_image,
                       name: "Doggo",
                       approximate_age: 3,
                       sex: "M",
                       shelter: @shelter1,
                       description: "What a cute animal!",
                       status: "Adoptable")
    @billy_joel = Application.create(name: "Billy Joel",
                                    address: "22 Jump Street",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80808",
                                    phone_number: "000000000",
                                    description: "Famous and rich")
    pet_app = PetApplication.create(pet_id: @doggo.id, application_id: @billy_joel.id )
    pet_app.change_status_to_approved
  end

  describe "As a visitor" do
    describe "When a PetApp has been approved" do
      it "I cannot delete the pet" do
        expect(@doggo.has_approved_app?).to eq(true)

        visit "/pets"
        within ".doggo-section" do
          expect(page).to_not have_link("Delete Pet")
        end

        visit "/shelters/#{@shelter1.id}/pets"
        within ".doggo-section" do
          expect(page).to_not have_link("Delete Pet")
        end

        visit "/pets/#{@doggo.id}"
        expect(page).to_not have_link("Delete Pet")
      end

    end
  end
end
