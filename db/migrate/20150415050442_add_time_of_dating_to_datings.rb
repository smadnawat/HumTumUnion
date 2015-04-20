class AddTimeOfDatingToDatings < ActiveRecord::Migration
  def change
    add_column :datings, :time_of_dating, :string
  end
end
