class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(params[:pet_id])
    session[:favorites] = favorites.pets
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @all_pets = Pet.all
    # @pending_pets = @all_pets.find_all do |pet|
    #   pet.status == "Pending"
    # end
    @pending_pets = Pet.where(status: "Pending")

    @pets = @all_pets.find_all { |pet| favorites.pets.has_key?(pet.id.to_s) }
    # @pets = favorites.favorite_pets
    flash[:notice] = "You have no favorited pets" if @pets.empty?
    # require "pry"; binding.pry
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet(params[:pet_id])
    flash[:notice] = "#{pet.name} has been removed from your favorites."
    redirect_back(fallback_location: "/favorites")
  end

  def delete_all
    session.clear
    redirect_back(fallback_location: "/favorites")
  end
end
