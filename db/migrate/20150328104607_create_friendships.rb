class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
     
      t.string :block
      t.string :accept
      t.references :user, index: true

      t.timestamps
    end
  end
end
