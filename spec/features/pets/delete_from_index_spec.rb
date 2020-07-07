require "rails_helper"

describe "Pet Delete From Pets Index Pages" do
  before(:each) do
    @doggo_house = Shelter.create(
      name: "Doggo House",
      address: "1323 Paper St",
      city: "Denver",
      state: "CO",
      zip: "000000")

    placeholder_image = "generic-image-placeholder.png"
    @dog1 = Pet.create(
      image: placeholder_image,
      name: "First Doggo",
      approximate_age: 3,
      sex: "M",
      shelter: @doggo_house,
      description: "What a cute animal!",
      status: "Adoptable"
    )

    @dog2 = Pet.create(
      image: placeholder_image,
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
      it "There is a link to delete that pet next to every pet" do
        visit "/pets"
        @dogs.each do |dog|
          expect(page).to have_text(dog.name)

          delete_link = "/pets/#{dog.id}"
          expect(page).to have_link("Delete Pet", href: delete_link)
        end
      end

      it "I can click the link to delete any pet" do
        visit "/pets"
        expect(page).to have_text("First Doggo")

        delete_link = "/pets/#{@dog1.id}"
        click_link("Delete Pet", href: delete_link)
        expect(current_path).to eql("/pets")

        expect(page).to_not have_text("First Doggo")
      end
    end

    describe "When I visit a shelter pets index page" do
      it "There is a link to delete that pet next to every pet" do
        visit "/shelters/#{@doggo_house.id}/pets"

        @dogs.each do |dog|
          expect(page).to have_text(dog.name)

          delete_link = "/pets/#{dog.id}"
          expect(page).to have_link("Delete Pet", href: delete_link)
        end
      end

      it "I can click the link to delete any pet" do
        visit "/shelters/#{@doggo_house.id}/pets"
        expect(page).to have_text("First Doggo")

        delete_link = "/pets/#{@dog1.id}"
        click_link("Delete Pet", href: delete_link)
        expect(current_path).to eql("/pets")

        expect(page).to_not have_text("First Doggo")
      end
    end
  end
end
