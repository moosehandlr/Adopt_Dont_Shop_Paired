class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  attribute :pet_app_status, default: "Not Approved"

  def change_status_to_approved
    self.pet_app_status = "Approved"
    self.save
  end

  def approved?
    self.pet_app_status == "Approved"
  end

  def change_status_to_not_approved
    self.pet_app_status = "Not Approved"
    self.save
  end
end
