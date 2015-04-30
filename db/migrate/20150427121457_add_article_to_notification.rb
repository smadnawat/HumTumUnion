class AddArticleToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :article, index: true
  end
end
