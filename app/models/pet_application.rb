class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  attribute :pet_app_status, default: "Not Approved"

  def change_status
    self.pet_app_status = "Approved"
  end
end
