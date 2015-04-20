class AddHobbyToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :hobby, :string
    add_reference :profiles, :user, index: true
  end
end
