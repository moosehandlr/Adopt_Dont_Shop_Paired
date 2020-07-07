class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image
      t.string :name
      t.string :sex
      t.integer :approximate_age

      t.timestamps
    end
  end
end
