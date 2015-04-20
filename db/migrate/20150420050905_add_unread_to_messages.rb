class AddUnreadToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :unread, :string
  end
end
