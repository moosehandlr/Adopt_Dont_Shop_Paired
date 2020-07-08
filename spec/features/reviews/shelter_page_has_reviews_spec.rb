require "rails_helper.rb"

RSpec.describe "Visiting '/shelters/:id'" do
  before(:each) do
    @shelter1 = Shelter.create!(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
    @shelter2 = Shelter.create!(name: "Catto House", address: "2124 N. Pencil Ave", city: "Denver", state: "CO", zip: "000000")
    @shelters = [@shelter1, @shelter2]
    @placeholder_image = "generic-image-placeholder.png"
    @image_name = @placeholder_image[0...-4]
    @review1 = Review.create!(title: "Review 1", rating: "4.5", content: "Clean with great customer service!", shelter_id: @shelter1.id)
    @review2 = Review.create!(title: "Review 2", rating: "3.2", content: "No dogs. Just cats.", image: @placeholder_image, shelter_id: @shelter2.id)

    #how to test for reviews and content
    #how to test for reviews and content
  end

  it "Has a review with no picture" do
   visit "/shelters/#{@shelter1.id}"

   expect(page).to have_content(@review1.title)
   expect(page).to have_content(@review1.rating)
   expect(page).to have_content(@review1.content)
  end

  it "Has a review with a picture" do
   visit "/shelters/#{@shelter2.id}"

   review_pic = find("#review-pic")
   expect(review_pic[:src]).to include(@image_name)
   expect(review_pic[:alt]).to eq("Photo of #{@shelter2.name}.")
   expect(page).to have_content(@review2.title)
   expect(page).to have_content(@review2.rating)
   expect(page).to have_content(@review2.content)
  end
end
