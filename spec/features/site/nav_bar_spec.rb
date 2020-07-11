require 'rails_helper'
describe "layouts/application.html.erb" do
  it "should have the right links in navbar" do
    visit "/"
    within(".navbar") do
      expect(page).to have_link("Home Page", href: "/")
      expect(page).to have_link("Pet Index", href: "/pets")
      expect(page).to have_link("Shelter Index", href: "/shelters")
    end
  end
end
