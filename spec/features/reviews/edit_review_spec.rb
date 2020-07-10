require "rails_helper"

RSpec.describe "Edit a Shelter Review" do
  describe "When I visit a shelter's show page and edit a review" do
    before :each do
      @shelter1 = Shelter.create!(
        name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000"
      )

      @shelter2 = Shelter.create!(
        name: "Catto House",
        address: "1333 Pencil St",
        city: "Aurora",
        state: "CO",
        zip: "100000"
      )

      @review1 = Review.create!(
        title: "Review 1",
        rating: "4.5",
        content: "Clean with great customer service!",
        shelter_id: @shelter1.id
      )

      @review2 = Review.create!(
        title: "Review Image",
        rating: "3.3",
        content: "Heres a existing image!",
        image: "https://www.hillside2b.com/uploads/4/6/9/9/46993477/3639061_orig.jpg",
        shelter_id: @shelter2.id
      )

      @review_edit_page = "/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit"
      @shelter_show_page = "/shelters/#{@shelter1.id}"
    end

    describe "I see the review form and it is pre-populated" do
      it "I can edit a review's title" do
        visit @shelter_show_page
        expect(page).to have_link("Edit Review")

        click_link "Edit Review"
        expect(current_path).to eq(@review_edit_page)

        expect(page).to have_selector("input[value='#{@review1.title}']")
        expect(page).to have_selector("input[value='#{@review1.rating}']")
        expect(page).to have_selector("input[value='#{@review1.content}']")

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

        expect(page).to have_selector("input[value='#{@review1.title}']")
        expect(page).to have_selector("input[value='#{@review1.rating}']")
        expect(page).to have_selector("input[value='#{@review1.content}']")

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

        expect(page).to have_selector("input[value='#{@review1.title}']")
        expect(page).to have_selector("input[value='#{@review1.rating}']")
        expect(page).to have_selector("input[value='#{@review1.content}']")

        fill_in :content, with: "They really clean up well!"
        click_button "Update Review"
        expect(current_path).to eq(@shelter_show_page)

        expect(page).to have_content("They really clean up well!")
      end

      it "If there is no image, I can add a image" do
        review_image_url = "https://paulsbuilding.com/wp-content/uploads/2016/05/Lobby-Building-Large-1350x500-1350x500.jpg"

        visit @shelter_show_page
        expect(page).to have_link("Edit Review")

        click_link "Edit Review"
        expect(current_path).to eq(@review_edit_page)

        expect(page).to have_selector("input[value='#{@review1.title}']")
        expect(page).to have_selector("input[value='#{@review1.rating}']")
        expect(page).to have_selector("input[value='#{@review1.content}']")

        fill_in :image, with: review_image_url
        click_button "Update Review"
        expect(current_path).to eq(@shelter_show_page)

        review_pic = find(".review-pic")
        expect(review_pic[:src]).to eq(review_image_url)
        expect(review_pic[:alt]).to eq("Photo of #{@shelter1.name}.")
      end

      it "If there is an existing image, I can add a new image" do
        review_image_url = "https://paulsbuilding.com/wp-content/uploads/2016/05/Lobby-Building-Large-1350x500-1350x500.jpg"

        visit "/shelters/#{@shelter2.id}"
        expect(page).to have_link("Edit Review")

        click_link "Edit Review"
        expect(current_path).to eq("/shelters/#{@shelter2.id}/reviews/#{@review2.id}/edit")

        expect(page).to have_selector("input[value='#{@review2.title}']")
        expect(page).to have_selector("input[value='#{@review2.rating}']")
        expect(page).to have_selector("input[value='#{@review2.content}']")
        expect(page).to have_selector("input[value='#{@review2.image}']")

        fill_in :image, with: review_image_url
        click_button "Update Review"
        expect(current_path).to eq("/shelters/#{@shelter2.id}")

        review_pic = find(".review-pic")
        expect(review_pic[:src]).to eq(review_image_url)
        expect(review_pic[:alt]).to eq("Photo of #{@shelter2.name}.")
      end
    end
  end
end
