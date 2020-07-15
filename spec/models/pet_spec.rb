require "rails_helper"

describe Pet, type: :model do
  describe "associations" do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications) }
    it { should have_many(:applications).through(:pet_applications)}
  end

  describe "validations" do
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:sex) }
    it { should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe "methods" do
    it "has a default status" do
      placeholder_image = "generic-image-placeholder.png"
      shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
      doggo = Pet.create(
        image: placeholder_image,
        name: "Doggo",
        approximate_age: 3,
        sex: "M",
        shelter: shelter1,
        description: "What a cute animal!")

      expect(doggo.status).to eq("Adoptable")
    end


    it "#change_status" do
      placeholder_image = "generic-image-placeholder.png"
      shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
      doggo = Pet.create(
        image: placeholder_image,
        name: "Doggo",
        approximate_age: 3,
        sex: "M",
        shelter: shelter1,
        description: "What a cute animal!",
        status: "Adoptable")

      expect(doggo.status).to eq("Adoptable")

      doggo.change_status_to_pending

      expect(doggo.status).to eq("Pending")

      doggo.change_status_to_adoptable

      expect(doggo.status).to eq("Adoptable")
    end

    it "#adoptable?" do
      placeholder_image = "generic-image-placeholder.png"
      shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
      doggo = Pet.create(
        image: placeholder_image,
        name: "Doggo",
        approximate_age: 3,
        sex: "M",
        shelter: shelter1,
        description: "What a cute animal!",
        status: "Adoptable")

      expect(doggo.adoptable?).to eq(true)
    end
  end
end
