class AddAboutToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :about, :string
  end
end
