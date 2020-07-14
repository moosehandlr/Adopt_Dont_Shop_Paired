class PetApplicationsController < ApplicationController
  def index
    @applicants = Pet.find(params[:pet_id]).applications
  end
end
