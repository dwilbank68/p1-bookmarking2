class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id#, index: true
      t.integer :bookmark_id#, index: true

      t.timestamps
    end
  end
end
