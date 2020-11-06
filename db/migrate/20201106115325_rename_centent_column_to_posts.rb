class RenameCententColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :centent, :content
  end
end
