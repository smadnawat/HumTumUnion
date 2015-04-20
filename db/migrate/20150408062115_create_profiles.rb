class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :contact
      t.string :image
      t.string :status
      t.string :about
      t.string :address
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
