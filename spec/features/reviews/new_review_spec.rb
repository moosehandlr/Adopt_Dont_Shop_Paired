require "rails_helper"

RSpec.describe "Shelter Review Creation" do
  describe "When I visit a shelter's show page" do
    before :each do
      @shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")

      @placeholder_image = "https://www.webfx.com/blog/images/cdn.designinstruct.com/files/582-how-to-image-placeholders/generic-image-placeholder.png"
      # @image_name = @placeholder_image[0...-4]
    end

    it "I can create a new review for that shelter without a picture" do
      visit "/shelters/#{@shelter1.id}"

      new_review_path = "/shelters/#{@shelter1.id}/reviews/new"

      expect(page).to have_link("Add Review", href: new_review_path)
      click_link "Add Review"

      expect(current_path).to eq(new_review_path)

      fill_in :title, with: "Smelly bathrooms"
      fill_in :rating, with: "1.2"
      fill_in :content, with: "This place stinks!"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_content("Smelly bathrooms")
      expect(page).to have_content("1.2")
      expect(page).to have_content("This place stinks!")
    end

    it "I can create a new review for that shelter with a picture" do
      visit "/shelters/#{@shelter1.id}"

      new_review_path = "/shelters/#{@shelter1.id}/reviews/new"

      expect(page).to have_link("Add Review", href: new_review_path)
      click_link "Add Review"

      expect(current_path).to eq(new_review_path)

      fill_in :title, with: "Smelly bathrooms"
      fill_in :rating, with: "1.2"
      fill_in :content, with: "This place stinks!"
      fill_in :image, with: @placeholder_image

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_content("Smelly bathrooms")
      expect(page).to have_content("1.2")
      expect(page).to have_content("This place stinks!")


      review_pic = find(".review-pic")
      expect(review_pic[:src]).to include(@placeholder_image)
      expect(review_pic[:alt]).to eq("Photo of #{@shelter1.name}.")
    end

  end
end
