class CreateComments < ActiveRecord::Migration
  def change
    create_table "comments", force: true do |t|
    t.string   "comment"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer   "Commenter"
    end

    add_index "comments", ["article_id"], name: "index_comments_on_article_id"

  end
end
