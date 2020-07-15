class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    pet
    if pet.pet_applications.any?(&:approved?)
      app_id = pet.pet_applications.detect(&:approved?).application_id
      @approved_name = Application.find(app_id).name
    end
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    Pet.create(create_pet_params)
    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def edit
    pet
  end

  def update
    pet.update(update_pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet.destroy
    redirect_to "/pets"
  end

  private
  def pet_params
    params.permit(:image, :name, :sex, :description, :approximate_age)
  end

  def create_pet_params
    create_params = pet_params
    create_params[:shelter_id] = params[:id]
    create_params
  end

  def update_pet_params
    pet_params.reject { |_, param| param.empty? }
  end

  def pet
    @pet = Pet.find(params[:id])
  end
end
