# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

placeholder_image = "generic-image-placeholder.png"

shelter1 = Shelter.create!(
  name: "Doggo House",
  address: "1323 Paper St",
  city: "Denver",
  state: "CO",
  zip: "000000")

doggo = Pet.create!(
  image: placeholder_image,
  name: "Doggo",
  approximate_age: 3,
  sex: "M",
  shelter: shelter1,
  description: "What a cute animal!",
  status: "Adoptable"
)

review1 = Review.create!(
  title: "Review 1",
  rating: "4.5",
  content: "Clean with great customer service!",
  shelter_id: shelter1.id)

review3 = Review.create!(
  title: "Review 3",
  rating: "4.6",
  content: "Great customer service and clean!",
  shelter_id: shelter1.id)

shelter2 = Shelter.create!(
  name: "Catto House",
  address: "2124 N. Pencil Ave",
  city: "Denver",
  state: "CO",
  zip: "000000")

catto = Pet.create!(
  image: placeholder_image,
  name: "Catto",
  approximate_age: 7,
  sex: "F",
  shelter: shelter2,
  description: "What a cute animal!",
  status: "Adoptable"
)

review2 = Review.create!(
  title: "Review 2",
  rating: "3.2",
  content: "No dogs. Just cats.",
  image: placeholder_image,
  shelter_id: shelter2.id)
