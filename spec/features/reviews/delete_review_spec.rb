RSpec.describe 'When I visit the shelters show page' do
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

  it "I see a link next to each shelter review to delete the review." do

    visit @shelter_show_page

    expect(page).to have_content("#{@review1.title}")

    click_button "Delete Review"

    expect(current_path).to eq(@shelter_show_page)
    expect(page).to_not have_content("#{@review1.title}")
  end
end
