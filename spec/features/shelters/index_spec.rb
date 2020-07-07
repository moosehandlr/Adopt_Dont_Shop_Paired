require "rails_helper.rb"

describe "Shelters Index Spec" do
  describe "When I visit /shelters" do
    it "there is the name of each shelter in the system" do
      shelter1 = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
      shelter2 = Shelter.create(name: "Catto House", address: "2124 N. Pencil Ave", city: "Denver", state: "CO", zip: "000000")
      shelter3 = Shelter.create(name: "Lizzo House", address: "5125 E. Book Cir", city: "Denver", state: "CO", zip: "000000")
      shelter4 = Shelter.create(name: "Liono House", address: "6126 Library Blvd", city: "Denver", state: "CO", zip: "000000")

      visit "/shelters"

      expect(page).to have_text(shelter1.name)
      expect(page).to have_text(shelter2.name)
      expect(page).to have_text(shelter3.name)
      expect(page).to have_text(shelter4.name)
    end
  end
end
