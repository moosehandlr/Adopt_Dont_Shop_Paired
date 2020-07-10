class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(create_review_params)

    if review.save
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Review not created. A new review needs to have a title, rating and content."
      redirect_to "/shelters/#{params[:id]}/reviews/new"
    end
  end

  def edit
    @shelter_id = params[:id]
    @review_id = params[:review_id]
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    if params.values_at(:title, :rating, :content).any? {|param| param.empty?}
    # if params[:title].empty? || params[:rating].empty? || params[:content].empty?
      flash[:notice] = "Review not updated. Title, rating and content required."
      redirect_to "/shelters/#{params[:id]}/reviews/#{params[:review_id]}/edit"
    else
      review.update(update_review_params)
      redirect_to "/shelters/#{params[:id]}"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end

  def update_review_params
    review_params.reject {|_, param | param.empty? }
  end

  def create_review_params
    c = review_params.to_hash
    c["image"] = nil if c["image"].empty?
    c
  end
end
