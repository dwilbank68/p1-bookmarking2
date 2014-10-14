class AddEmbedToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :embed, :string
  end
end
