require "rails_helper"

describe "Pet Update Spec" do
  describe "When I visit a Pet Show page" do
    it "I can edit all of a pet's information" do
      placeholder_image = "generic-image-placeholder.png"
      image_name = placeholder_image[0...-4]

      doggo_house = Shelter.create(name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000"
      )

      doggo = Pet.create(image: placeholder_image,
        name: "Doggo",
        approximate_age: 3,
        sex: "M",
        shelter: doggo_house,
        description: "What a cute animal!",
        status: "Adoptable"
      )

      show_page = "/pets/#{doggo.id}"

      visit show_page
      click_link "Update Pet"
      expect(current_path).to eql("#{show_page}/edit")

      new_image = "https://www.webfx.com/blog/images/cdn.designinstruct.com/files/582-how-to-image-placeholders/generic-image-placeholder.png"

      fill_in :image, with: new_image
      fill_in "Name", with: "Super Doggo"
      fill_in "Description", with: "What a cute dog!"
      fill_in :approximate_age, with: "5"
      fill_in "Sex", with: "male"

      click_button("Update Pet")
      expect(current_path).to eql(show_page)

      doggo_image = find("#super-doggo-image")
      expect(doggo_image[:src]).to eq(new_image)
      expect(doggo_image[:alt]).to eq("Photo of Super Doggo.")

      expect(page).to have_text("Name: Super Doggo")
      expect(page).to have_text("Description: What a cute dog!")
      expect(page).to have_text("Age: 5")
      expect(page).to have_text("Sex: male")
    end

    it "I can edit some of a pet's information" do
      placeholder_image = "generic-image-placeholder.png"
      image_name = placeholder_image[0...-4]

      doggo_house = Shelter.create(name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000"
      )

      doggo = Pet.create(image: placeholder_image,
        name: "Doggo",
        approximate_age: 3,
        sex: "M",
        shelter: doggo_house,
        description: "What a cute animal!",
        status: "Adoptable"
      )

      show_page = "/pets/#{doggo.id}"

      visit show_page
      click_link "Update Pet"
      expect(current_path).to eql("#{show_page}/edit")

      new_image = "https://www.webfx.com/blog/images/cdn.designinstruct.com/files/582-how-to-image-placeholders/generic-image-placeholder.png"

      fill_in :image, with: new_image
      fill_in "Name", with: "Super Doggo"

      click_button("Update Pet")
      expect(current_path).to eql(show_page)

      doggo_image = find("#super-doggo-image")
      expect(doggo_image[:src]).to eq(new_image)
      expect(doggo_image[:alt]).to eq("Photo of Super Doggo.")

      expect(page).to have_text("Name: Super Doggo")
      expect(page).to have_text("Description: What a cute animal!")
      expect(page).to have_text("Age: 3")
      expect(page).to have_text("Sex: M")

    end


  end
end
