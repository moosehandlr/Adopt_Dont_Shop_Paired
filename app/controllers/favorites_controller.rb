class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(params[:pet_id])
    session[:favorites] = favorites.pets
    flash.now[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @pending_pets = PetApplication.pets_with_apps
    flash.now[:notice] = "You have no favorited pets" if favorites.favorite_pets.empty?
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet(params[:pet_id])
    flash.now[:notice] = "#{pet.name} has been removed from your favorites."
    redirect_back(fallback_location: "/favorites")
  end

  def delete_all
    session.clear
    redirect_back(fallback_location: "/favorites")
  end
end
