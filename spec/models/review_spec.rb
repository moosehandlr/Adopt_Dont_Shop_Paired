require "rails_helper"

RSpec.describe Review, type: :model do
  describe "associations" do
    it { should belong_to(:shelter) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:image).allow_nil }
  end

  describe "methods" do
    it "::average_rating" do
      shelter1 = Shelter.create(name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000")

      review1 = Review.create!(
        title: "Review 1",
        rating: "5",
        content: "Clean with great customer service!",
        shelter_id: shelter1.id)

      review2 = Review.create!(
        title: "Review 2",
        rating: "4",
        content: "Great customer service and clean!",
        shelter_id: shelter1.id)

      expect(shelter1.reviews.average_rating).to eq(4.5)
    end
  end
end
