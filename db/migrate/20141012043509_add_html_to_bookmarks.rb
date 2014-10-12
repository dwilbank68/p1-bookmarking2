class AddHtmlToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :html, :string
  end
end
