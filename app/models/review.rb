class Review < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :title, :rating, :content
  validates_presence_of :image, allow_nil: true

  def self.average_rating
    if Review.all.empty?
      0
    else
      average = Review.pluck(:rating).map(&:to_f).sum / Review.all.size
      average.round(2)
    end
  end
end
