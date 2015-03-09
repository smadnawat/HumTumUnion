class AddCommenterToComments < ActiveRecord::Migration
  def change
    add_column :comments, :Commenter, :string
  end
end
