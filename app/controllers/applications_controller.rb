class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites.pets.each_key.map(&:to_i)
    @pets = pet_ids.map { |pet_id| Pet.find(pet_id) }
  end

  def create
    selected_pets = params.keys.find_all { |key| key.include?("select-") }
    selected_pets.each { |pet| favorites.remove_pet(params[pet]) }
    flash[:submitted] = "Application successfully submitted!"
    redirect_to "/favorites"
  end
end
