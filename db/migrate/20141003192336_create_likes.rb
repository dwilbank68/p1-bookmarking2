class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :bookmark, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
