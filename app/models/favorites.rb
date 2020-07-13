class Favorites
  attr_reader :pets

  def initialize(initial_pets)
    @pets = initial_pets || Hash.new(0)
  end

  def total_count
    @pets.values.sum
  end

  def add_pet(id)
    pet_id = id.to_s
    @pets[pet_id] ||= 0
    @pets[pet_id] += 1
  end

  def remove_pet(id)
    @pets.delete_if { |pet_id, _| pet_id == id.to_s }
  end

  def favorite_pets
    @pets.keys.map do |pet_key|
      Pet.find(pet_key.to_i)
    end
  end
end
