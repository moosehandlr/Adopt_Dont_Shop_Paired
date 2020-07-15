require "rails_helper"

describe "Pet Update From Pets Index Pages" do
  before(:each) do
    @doggo_house = Shelter.create(
      name: "Doggo House",
      address: "1323 Paper St",
      city: "Denver",
      state: "CO",
      zip: "000000")

    @placeholder_image = "generic-image-placeholder.png"

    @dog1 = Pet.create(
      image: @placeholder_image,
      name: "First Doggo",
      approximate_age: 3,
      sex: "M",
      shelter: @doggo_house,
      description: "What a cute animal!",
      status: "Adoptable"
    )

    @dog2 = Pet.create(
      image: @placeholder_image,
      name: "Second Doggo",
      approximate_age: 2,
      sex: "F",
      shelter: @doggo_house,
      description: "What a cute animal!",
      status: "Adoptable"
    )

    @dogs = [@dog1, @dog2]
  end

  describe "As a visitor" do
    describe "When I visit the pets index page" do
      it "There is a link to edit that pet's info next to every pet" do
        visit "/pets"
        @dogs.each do |dog|
          expect(page).to have_text(dog.name)

          update_link = "/pets/#{dog.id}/edit"
          expect(page).to have_link("Update Pet", href: update_link)
        end
      end

      it "I can click the link to edit any pet" do
        visit "/pets"
        expect(page).to have_text("First Doggo")

        update_link = "/pets/#{@dog1.id}/edit"
        click_link("Update Pet", href: update_link)
        expect(current_path).to eql(update_link)

        fill_in :image, with: @placeholder_image
        fill_in :name, with: "Super Dog"
        fill_in "Sex", with: "male"
        fill_in "Description", with: "What a ferociously cuddly lion!"
        fill_in :approximate_age, with: "80"

        click_button "Update Pet"

        expect(current_path).to eql("/pets/#{@dog1.id}")
        expect(page).to have_text("Super Dog")
        expect(page).to_not have_text("First Doggo")
      end
    end

    describe "When I visit a shelter pets index page" do
      it "There is a link to edit that pet's info next to every pet" do
        visit "/shelters/#{@doggo_house.id}/pets"

        @dogs.each do |dog|
          expect(page).to have_text(dog.name)

          update_link = "/pets/#{dog.id}/edit"
          expect(page).to have_link("Update Pet", href: update_link)
        end
      end

      it "I can click the link to edit any pet" do
        visit "/shelters/#{@doggo_house.id}/pets"
        expect(page).to have_text("First Doggo")

        update_link = "/pets/#{@dog1.id}/edit"
        click_link("Update Pet", href: update_link)
        expect(current_path).to eql(update_link)

        fill_in :image, with: @placeholder_image
        fill_in :name, with: "Super Dog"
        fill_in "Sex", with: "male"
        fill_in "Description", with: "What a ferociously cuddly lion!"
        fill_in :approximate_age, with: "80"

        click_button "Update Pet"

        expect(current_path).to eql("/pets/#{@dog1.id}")
        expect(page).to have_text("Super Dog")
        expect(page).to_not have_text("First Doggo")
      end
    end
  end
end
