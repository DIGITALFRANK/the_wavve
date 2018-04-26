
class CreateSubtags < ActiveRecord::Migration[5.2]
  def change
    create_table :subtags do |t|
      t.string :subtag_name
      t.string :tag_id
    end
  end
end