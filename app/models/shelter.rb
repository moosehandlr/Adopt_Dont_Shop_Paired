class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name, :address, :city, :state, :zip

  def has_approved_app?
    self.pets.any?(&:has_approved_app?)
  end

end
