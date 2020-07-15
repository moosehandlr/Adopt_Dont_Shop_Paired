class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :image, :name, :sex, :description, :status
  validates :approximate_age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  attribute :status, default: "Adoptable"

  def change_status_to_pending
    self.status = "Pending"
    self.save
  end

  def adoptable?
    self.status == "Adoptable"
  end

  def change_status_to_adoptable
    self.status = "Adoptable"
    self.save
  end

  def has_approved_app?
    pet_apps = PetApplication.where(pet_id: self.id)
    pet_apps.any?(&:approved?)
  end
end
