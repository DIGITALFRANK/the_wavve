
class CreatePostsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :poststags do |t|
      t.integer :post_id
      t.integer :tag_id
    end
  end
end