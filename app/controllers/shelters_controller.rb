class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
  end

  def new
  end

  def create
    Shelter.create(shelter_params)
    redirect_to "/shelters"
  end

  def edit
    shelter
  end

  def update
    shelter.update(update_params)
    shelter.save
    redirect_to "/shelters"
  end

  def destroy
    shelter.destroy
    redirect_to "/shelters"
  end

  def pets_index
    shelter
  end

  private
  def shelter
    @shelter = Shelter.find(params[:id])
  end

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def update_params
    shelter_params.reject { |_, param| param.empty? }
  end
end
