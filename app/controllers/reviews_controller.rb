class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    create_review_params = review_params.to_hash
    create_review_params["image"] = nil if create_review_params["image"].empty?

    # review = shelter.reviews.create!(create_review_params)
    review = shelter.reviews.new(create_review_params)

    if review.save
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Review not created. A new review needs to have a title, rating and content."
      redirect_to "/shelters/#{params[:id]}/reviews/new"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end