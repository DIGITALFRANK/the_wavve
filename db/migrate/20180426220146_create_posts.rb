
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :img_url
      t.string :title
      t.string :subtitle
      t.string :text_content

      t.integer :user_id
    end
  end
end