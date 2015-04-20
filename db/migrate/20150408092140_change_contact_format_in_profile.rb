class ChangeContactFormatInProfile < ActiveRecord::Migration
   def up
   change_column :profiles, :contact, :string
  end

  def down
   change_column :profiles, :contact, :string
  end
end
