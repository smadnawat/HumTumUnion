class AddMessageToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :message, :text
  end
end
