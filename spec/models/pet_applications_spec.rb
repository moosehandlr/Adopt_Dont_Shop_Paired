require "rails_helper"

RSpec.describe PetApplication do
  describe "relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe "methods" do
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
      @billy_joel = Application.create!(name: "Billy Joel",
        address: "22 Jump Street",
        city: "Denver",
        state: "CO",
        zip: "80808",
        phone_number: "000000000",
        description: "Famous and rich")
      @pet_app = PetApplication.create!(pet_id: @doggo.id, application_id: @billy_joel.id )
    end

    it "has a default status" do
      expect(@pet_app.pet_app_status).to eq("Not Approved")
    end

    it "can change_status" do
      @pet_app.change_status
      expect(@pet_app.pet_app_status).to eq("Approved")

      @pet_app.change_status
      expect(@pet_app.pet_app_status).to eq("Not Approved")

      @pet_app.change_status
      expect(@pet_app.pet_app_status).to eq("Approved")
    end

    it "knows if it is approved" do
      expect(@pet_app.pet_app_status).to eq("Not Approved")
      expect(@pet_app.approved?).to eq(false)

      @pet_app.change_status
      expect(@pet_app.approved?).to eq(true)
    end
  end

end
