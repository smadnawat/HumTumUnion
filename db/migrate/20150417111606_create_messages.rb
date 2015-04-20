class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.string :image
      t.integer :reciever
      t.references :user, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
