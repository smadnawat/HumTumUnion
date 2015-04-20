class CreateLikes < ActiveRecord::Migration
  def change
    create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["article_id"], name: "index_likes_on_article_id"

  end
end
