class Review < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :image, :name, :sex, :description, :status
end
