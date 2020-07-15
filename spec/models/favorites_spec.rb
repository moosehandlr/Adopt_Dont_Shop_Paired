require 'rails_helper'

RSpec.describe Favorites do

  describe "#total_count" do
    it "can count all of the pets" do
      favorites = Favorites.new({
        '1' => 3,
        '2' => 3
      })
      expect(favorites.total_count).to eq(6)
    end
  end

  describe "#add_pet(id)" do
    it "can add pet" do
      favorites = Favorites.new({
        '1' => 3,
        '2' => 3
      })
      favorites.add_pet(2)
      expect(favorites.total_count).to eq(7)
    end
  end

  describe "#remove_pet(id)" do
    it "can remove pet" do
      favorites = Favorites.new({
        '1' => 3,
        '2' => 3
      })
      favorites.remove_pet(2)
      expect(favorites.total_count).to eq(3)
        expect(favorites.pets).to eq({'1' => 3})
    end
  end

  describe "#favorite_pets" do
    it "can return favorite pets" do
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

      catto = Pet.create(image: placeholder_image,
                         name: "Catto",
                         approximate_age: 7,
                         sex: "F",
                         shelter: shelter1,
                         description: "What a cute animal!",
                         status: "Adoptable")

      favorites = Favorites.new({"#{doggo.id}"=>1, "#{catto.id}"=>1})

      expect(favorites.favorite_pets).to eq([doggo, catto])
    end
  end
end
