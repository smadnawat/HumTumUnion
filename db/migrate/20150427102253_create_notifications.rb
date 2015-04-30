class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notificable, polymorphic: true, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
