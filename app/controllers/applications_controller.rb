class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites.pets.each_key.map(&:to_i)
    @pets = pet_ids.map { |pet_id| Pet.find(pet_id) }
  end

  def create

    selected_pets = params.keys.find_all { |key| key.include?("select-") }

    if applications_params.values.any?(&:empty?) || selected_pets.empty?
      flash[:submitted] = "Form must be completed and pets selected in order to submit the application."
      redirect_to "/applications/new"
    else
      selected_pets.each do |pet|
        p = Pet.find(params[pet].to_i)
        p.change_status
        p.save
        favorites.remove_pet(params[pet])
      end
      flash[:submitted] = "Application successfully submitted!"
      redirect_to "/favorites"
    end
  end

  private

  def applications_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
