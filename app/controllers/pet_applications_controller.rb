class PetApplicationsController < ApplicationController
  def index
    @applicants = Pet.find(params[:pet_id]).applications
  end

  def update
    pet_app = PetApplication.where(pet_id: params[:pet_id], application_id: params[:applicant_id]).first
    pet_app.change_status_to_approved
    pet = Pet.find(params[:pet_id])
    pet.change_status_to_pending
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def unapprove
    pet_app = PetApplication.where(pet_id: params[:pet_id], application_id: params[:applicant_id]).first
    pet_app.change_status_to_not_approved
    pet = Pet.find(params[:pet_id])
    pet.change_status_to_adoptable
    redirect_to "/applications/#{params[:applicant_id]}"
  end
end
