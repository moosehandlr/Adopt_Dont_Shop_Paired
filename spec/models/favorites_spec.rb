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
end
