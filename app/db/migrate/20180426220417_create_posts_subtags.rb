
class CreatePostsSubtags < ActiveRecord::Migration[5.2]
  def change
    create_table :postssubtags do |t|
      t.integer :post_id
      t.integer :tag_id
      t.integer :subtag_id
    end
  end
end