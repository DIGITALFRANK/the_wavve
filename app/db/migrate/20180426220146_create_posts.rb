
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :media_url
      t.string :text_content

      t.integer :user_id
    end
  end
end