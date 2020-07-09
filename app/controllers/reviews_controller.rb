class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    r = review_params.to_hash
    r["image"] = nil if r["image"].empty?
    review = shelter.reviews.create!(r)
    redirect_to "/shelters/#{params[:id]}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
