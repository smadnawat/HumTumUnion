class AddZipcodeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :zipcode, :integer
  end
end
