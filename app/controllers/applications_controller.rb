class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites.pets.each_key.map(&:to_i)
    @pets = pet_ids.map { |pet_id| Pet.find(pet_id) }
  end

  def create
    selected_pets = params.keys.find_all { |key| key.include?("select-") }
    application = Application.new(applications_params)

    if application.save && !selected_pets.empty?
      application.pets << selected_pets.map { |pet| Pet.find(params[pet].to_i) }
      application.pets.each do |pet|
        pet.change_status
        pet.save
        PetApplication.create(pet_id: pet.id, application_id: application.id )
        favorites.remove_pet(pet.id)
      end
      flash[:submitted] = "Application successfully submitted!"
      redirect_to "/favorites"
    else
      flash[:submitted] = "Form must be completed and pets selected in order to submit the application."
      redirect_to "/applications/new"
    end
  end

  def show
    @applicant = Application.find(params[:id])
  end

  private

  def applications_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
