class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(params[:pet_id])
    session[:favorites] = favorites.pets
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @pets = Pet.all
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet(params[:pet_id])
    flash[:notice] = "#{pet.name} has been removed from your favorites."
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
