require "rails_helper.rb"

describe "Visiting '/shelters/:id'" do
  it "displays that shelter's name, address, city, state, and zip" do
    doggo_house = Shelter.create(name: "Doggo House", address: "1323 Paper St", city: "Denver", state: "CO", zip: "000000")
    catto_house = Shelter.create(name: "Catto House", address: "2124 N. Pencil Ave", city: "Denver", state: "CO", zip: "000000")

    visit "/shelters/#{doggo_house.id}"

    expect(page).to have_text(doggo_house.name)
    expect(page).to have_text(doggo_house.address)
    expect(page).to have_text(doggo_house.city)
    expect(page).to have_text(doggo_house.state)
    expect(page).to have_text(doggo_house.zip)

    expect(page).to_not have_text(catto_house.name)
    expect(page).to_not have_text(catto_house.address)
  end
end
