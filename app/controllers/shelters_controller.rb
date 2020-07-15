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
    new_shelter = Shelter.new(shelter_params)
    if new_shelter.save
      redirect_to "/shelters"
    else
      empty_params = shelter_params.to_h.map {|k, v| k if v.empty? }.compact.join(", ")
      flash[:submitted] = "Please add #{empty_params} information before submitting."
      redirect_to "/shelters/new"
    end
  end

  def edit
    shelter
  end

  def update
    if shelter.update(shelter_params)
      shelter.save
      redirect_to "/shelters"
    else
      empty_params = shelter_params.to_h.map {|k, v| k if v.empty? }.compact.join(", ")
      flash[:submitted] = "Please add #{empty_params} information before submitting."
      redirect_to "/shelters/#{shelter.id}/edit"
    end
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
end
