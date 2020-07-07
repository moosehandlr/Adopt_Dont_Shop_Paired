require "rails_helper"

describe "Shelter Pet Index Link" do
  describe "When I visit a shelter show page" do
    before(:each) do
      @shelter1 = Shelter.create(
        name: "Doggo House",
        address: "1323 Paper St",
        city: "Denver",
        state: "CO",
        zip: "000000")

      @shelter2 = Shelter.create(
        name: "Catto House",
        address: "2124 N. Pencil Ave",
        city: "Denver",
        state: "CO",
        zip: "000000")

      @shelter3 = Shelter.create(
        name: "Lizzo House",
        address: "5125 E. Book Cir",
        city: "Denver",
        state: "CO",
        zip: "000000")

      @shelter4 = Shelter.create(
        name: "Liono House",
        address: "6126 Library Blvd",
        city: "Denver",
        state: "CO",
        zip: "000000")

      @shelters = [@shelter1, @shelter2, @shelter3, @shelter4]
    end

    it "There is a link to go to that shelter's pets page" do
      @shelters.each do |shelter|
        shelter_page = "/shelters/#{shelter.id}"
        shelter_pets_link = "See all the pets at #{shelter.name}"
        
        visit shelter_page
        expect(page).to have_link(shelter_pets_link, href: shelter_page + "/pets")
      end
    end
  end
end
