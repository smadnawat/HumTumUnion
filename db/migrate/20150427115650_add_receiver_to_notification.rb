class AddReceiverToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :receiver, :integer
  end
end
