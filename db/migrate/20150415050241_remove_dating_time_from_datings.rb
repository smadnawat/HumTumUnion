class RemoveDatingTimeFromDatings < ActiveRecord::Migration
  def change
    remove_column :datings, :dating_time, :date
  end
end
