require "rails_helper"

RSpec.describe "Shelter Review Creation Sad Path Spec" do
  describe "When I visit a shelter and make a new review" do
    before :each do
      @shelter1 = Shelter.create(
        name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000"
      )
    end

    it "I cannot create a review without a title" do
      visit "/shelters/#{@shelter1.id}"

      click_link "Add Review"

      fill_in :rating, with: "1.2"
      fill_in :content, with: "This place stinks!"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      expect(page).to have_content("Review not created. A new review needs to have a title, rating and content.")
      expect(page).to have_button("Submit Review")
    end

    it "I cannot create a review without a rating" do
      visit "/shelters/#{@shelter1.id}"

      click_link "Add Review"

      fill_in :title, with: "Smelly bathrooms"
      fill_in :content, with: "This place stinks!"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      expect(page).to have_content("Review not created. A new review needs to have a title, rating and content.")
      expect(page).to have_button("Submit Review")
    end

    it "I cannot create a review without content" do
      visit "/shelters/#{@shelter1.id}"

      click_link "Add Review"

      fill_in :title, with: "Smelly bathrooms"
      fill_in :rating, with: "1.2"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      expect(page).to have_content("Review not created. A new review needs to have a title, rating and content.")
      expect(page).to have_button("Submit Review")
    end
  end
end
