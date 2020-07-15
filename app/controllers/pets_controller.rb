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
    new_pet = Pet.new(create_pet_params)
    if new_pet.save
      redirect_to "/shelters/#{params[:id]}/pets"
    else
      empty_params = pet_params.to_h.map {|k, v| k if v.empty? }.compact.join(", ")
      flash[:submitted] = "Please add #{empty_params} information before submitting."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    end
  end

  def edit
    pet
  end

  def update
    if pet.update(pet_params)
      pet.save
      redirect_to "/pets/#{params[:id]}"
    else
      empty_params = pet_params.to_h.map {|k, v| k if v.empty? }.compact.join(", ")
      flash[:submitted] = "Please add #{empty_params} information before submitting."
      redirect_to "/pets/#{params[:id]}/edit"
    end
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

  def pet
    @pet = Pet.find(params[:id])
  end
end
