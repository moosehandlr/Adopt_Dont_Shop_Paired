require "rails_helper.rb"

RSpec.describe Shelter, type: :model do
  describe "associations" do
    it { should have_many(:pets) }
    it { should have_many(:reviews) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  describe "methods" do
    it "#has_approved_app?" do
      placeholder_image = "generic-image-placeholder.png"
      shelter1 = Shelter.create(name: "Doggo House",
                                address: "1323 Paper St",
                                city: "Denver",
                                state: "CO",
                                zip: "000000")
      doggo = Pet.create(image: placeholder_image,
                         name: "Doggo",
                         approximate_age: 3,
                         sex: "M",
                         shelter: shelter1,
                         description: "What a cute animal!",
                         status: "Adoptable")

      billy_joel = Application.create(name: "Billy Joel",
                                      address: "22 Jump Street",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80808",
                                      phone_number: "000000000",
                                      description: "Famous and rich")
      pet_app = PetApplication.create(pet_id: doggo.id, application_id: billy_joel.id )

      expect(shelter1.has_approved_app?).to eq(false)

      expect(pet_app.approved?).to eq(false)
      expect(shelter1.has_approved_app?).to eq(false)

      pet_app.change_status_to_approved
      expect(pet_app.approved?).to eq(true)
      expect(shelter1.has_approved_app?).to eq(true)

      pet_app.change_status_to_not_approved
      expect(pet_app.approved?).to eq(false)
      expect(shelter1.has_approved_app?).to eq(false)
    end
  end
end
