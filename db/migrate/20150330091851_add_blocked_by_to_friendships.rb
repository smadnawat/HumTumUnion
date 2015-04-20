class AddBlockedByToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :blocked_by, :integer
  end
end
