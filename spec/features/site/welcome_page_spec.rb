require "rails_helper"

describe "The Welcome Page" do
  describe "When I visit the home page" do
    it "has a link to the home page" do
      visit "/"

      expect(page).to have_link("Home Page", href: "/")
    end
    it "has links to a Pets and Shelter indices" do
      visit "/"

      expect(page).to have_link("Shelter Index", href: "/shelters")
      expect(page).to have_link("Pet Index", href: "/pets")
    end
  end
end
