class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user_id, index: true
      t.references :bookmark_id, index: true

      t.timestamps
    end
  end
end
