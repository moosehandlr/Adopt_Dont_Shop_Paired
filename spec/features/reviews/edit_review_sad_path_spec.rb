require "rails_helper"

RSpec.describe "Edit a Shelter Review Sad Path Spec" do
  describe "When I visit a shelter's show page and incorrectly update review" do
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

    describe "I see a flash message indicating that" do
      it "I cannot leave review's title blank" do
        visit @shelter_show_page

        click_link "Edit Review"
        expect(current_path).to eq(@review_edit_page)

        fill_in :title, with: ""
        click_button "Update Review"
        expect(current_path).to eq(@review_edit_page)

        expect(page).to have_content("Review not updated. Title, rating and content required.")
        expect(page).to have_button("Update Review")
      end

      it "I cannot leave review's rating blank" do
        visit @shelter_show_page

        click_link "Edit Review"
        expect(current_path).to eq(@review_edit_page)

        fill_in :rating, with: ""
        click_button "Update Review"
        expect(current_path).to eq(@review_edit_page)

        expect(page).to have_content("Review not updated. Title, rating and content required.")
        expect(page).to have_button("Update Review")
      end

      it "I cannot leave review's content blank" do
        visit @shelter_show_page

        click_link "Edit Review"
        expect(current_path).to eq(@review_edit_page)

        fill_in :content, with: ""
        click_button "Update Review"
        expect(current_path).to eq(@review_edit_page)

        expect(page).to have_content("Review not updated. Title, rating and content required.")
        expect(page).to have_button("Update Review")
      end

      it "I cannot leave review's title,rating,and content blank" do
        visit @shelter_show_page

        click_link "Edit Review"
        expect(current_path).to eq(@review_edit_page)

        fill_in :title, with: ""
        fill_in :rating, with: ""
        fill_in :content, with: ""
        click_button "Update Review"
        expect(current_path).to eq(@review_edit_page)

        expect(page).to have_content("Review not updated. Title, rating and content required.")
        expect(page).to have_button("Update Review")
      end
    end
  end
end
