require "rails_helper"

RSpec.describe "Edit a Shelter Review" do
  describe "When I visit a shelter's show page" do
    before :each do
      @shelter1 = Shelter.create!(
        name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000"
      )

      @review1 = Review.create!(
        title: "Review 1",
        rating: "4.5",
        content: "Clean with great customer service!",
        shelter_id: @shelter1.id
      )
      
      @review_edit_page = "/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit"
      @shelter_show_page = "/shelters/#{@shelter1.id}"
    end

    it "I can edit a review's title" do
      visit @shelter_show_page
      expect(page).to have_link("Edit Review")

      click_link "Edit Review"
      expect(current_path).to eq(@review_edit_page)

      fill_in :title, with: "Smells great!"
      click_button "Update Review"
      expect(current_path).to eq(@shelter_show_page)

      expect(page).to have_content("Smells great!")
    end


    it "I can edit a review's rating " do
      visit @shelter_show_page
      expect(page).to have_link("Edit Review")

      click_link "Edit Review"
      expect(current_path).to eq(@review_edit_page)

      fill_in :rating, with: "5.0"
      click_button "Update Review"
      expect(current_path).to eq(@shelter_show_page)

      expect(page).to have_content("5.0")
    end

    it "I can edit a review's content" do
      visit @shelter_show_page
      expect(page).to have_link("Edit Review")

      click_link "Edit Review"
      expect(current_path).to eq(@review_edit_page)

      fill_in :content, with: "They really clean up well!"
      click_button "Update Review"
      expect(current_path).to eq(@shelter_show_page)

      expect(page).to have_content("They really clean up well!")
    end

    it "I can edit a review's image" do
      review_image_url = "https://paulsbuilding.com/wp-content/uploads/2016/05/Lobby-Building-Large-1350x500-1350x500.jpg"

      visit @shelter_show_page
      expect(page).to have_link("Edit Review")

      click_link "Edit Review"
      expect(current_path).to eq(@review_edit_page)

      fill_in :image, with: review_image_url
      click_button "Update Review"
      expect(current_path).to eq(@shelter_show_page)

      review_pic = find(".review-pic")
      expect(review_pic[:src]).to eq(review_image_url)
      expect(review_pic[:alt]).to eq("Photo of #{@shelter1.name}.")
    end

  end
end
