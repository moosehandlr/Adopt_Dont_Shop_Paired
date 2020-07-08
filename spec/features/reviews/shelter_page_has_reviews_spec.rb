require "rails_helper.rb"

RSpec.describe "Visiting '/shelters/:id'" do
  before(:each) do
    @shelter1 = Shelter.create!(
      name: "Doggo House",
      address: "1323 Paper St",
      city: "Denver",
      state: "CO",
      zip: "000000")

    @shelter2 = Shelter.create!(
      name: "Catto House",
      address: "2124 N. Pencil Ave",
      city: "Denver",
      state: "CO",
      zip: "000000")

    @review1 = Review.create!(
      title: "Review 1",
      rating: "4.5",
      content: "Clean with great customer service!",
      shelter_id: @shelter1.id)

    @review3 = Review.create!(
      title: "Review 3",
      rating: "4.6",
      content: "Great customer service and clean!",
      shelter_id: @shelter1.id)

    @reviews_at_shelter1 = [@review1, @review3]

    @placeholder_image = "generic-image-placeholder.png"
    @image_name = @placeholder_image[0...-4] # generic-image-placeholder

    @review2 = Review.create!(
      title: "Review 2",
      rating: "3.2",
      content: "No dogs. Just cats.",
      image: @placeholder_image,
      shelter_id: @shelter2.id)
  end

  it "Has reviews with no pictures" do
   visit "/shelters/#{@shelter1.id}"

   @reviews_at_shelter1.each do |review|
     expect(page).to have_content(review.title)
     expect(page).to have_content(review.rating)
     expect(page).to have_content(review.content)
   end
  end

  it "Has a review with a picture" do
   visit "/shelters/#{@shelter2.id}"

   review_pic = find(".review-pic")
   expect(review_pic[:src]).to include(@image_name)
   expect(review_pic[:alt]).to eq("Photo of #{@shelter2.name}.")
   expect(page).to have_content(@review2.title)
   expect(page).to have_content(@review2.rating)
   expect(page).to have_content(@review2.content)
  end
end
