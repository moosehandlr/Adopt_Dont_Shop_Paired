class PetApplicationsController < ApplicationController
  def index
    @applicants = Pet.find(params[:pet_id]).applications
  end

  def update
    pet_app = PetApplication.where(pet_id: params[:pet_id],
                           application_id: params[:applicant_id]).first
    pet_app.change_status
    pet_app.save
    pet = Pet.find(params[:pet_id])
    pet.change_status
    pet.save
    redirect_to "/pets/#{params[:pet_id]}"
  end

end
