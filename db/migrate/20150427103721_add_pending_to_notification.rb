class AddPendingToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :pending, :boolean
  end
end
