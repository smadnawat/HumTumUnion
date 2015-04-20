class CreateArticles < ActiveRecord::Migration
  def change
     create_table "articles", force: true do |t|
     t.string   "title"
     t.string   "text"
     t.integer  "user_id"
     t.datetime "created_at"
     t.datetime "updated_at"
     t.string   "image"
     t.date     "date"
     end

     add_index "articles", ["user_id"], name: "index_articles_on_user_id"
  end
end
