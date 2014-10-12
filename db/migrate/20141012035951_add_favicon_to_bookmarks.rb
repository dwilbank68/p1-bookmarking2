class AddFaviconToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :favicon, :string
  end
end
