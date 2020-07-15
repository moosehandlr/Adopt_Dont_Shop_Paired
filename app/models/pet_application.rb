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

  def self.pets_with_apps
    self.all.map do |pet_app|
      Pet.find(pet_app.pet_id)
    end.uniq
  end
end
