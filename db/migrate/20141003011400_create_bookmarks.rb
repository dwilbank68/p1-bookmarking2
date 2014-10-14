class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string      :url
      t.string      :title
      t.string      :description
      t.references  :topic, index: true
      t.references  :user, index: true

      t.timestamps
    end
  end
end
