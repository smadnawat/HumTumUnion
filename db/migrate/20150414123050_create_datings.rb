class CreateDatings < ActiveRecord::Migration
  def change
    create_table :datings do |t|
      t.integer :datable_id
      t.integer :date_id
      t.boolean :accept
      t.time :dating_time

      t.timestamps
    end
  end
end
