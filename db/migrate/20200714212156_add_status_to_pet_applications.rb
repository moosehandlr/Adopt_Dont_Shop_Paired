class AddStatusToPetApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :pet_app_status, :string
  end
end
