class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string      :url
      t.string      :title
      t.text        :description
      t.text        :embed
      t.references  :topic, index: true
      t.references  :user, index: true

      t.timestamps
    end
  end
end
