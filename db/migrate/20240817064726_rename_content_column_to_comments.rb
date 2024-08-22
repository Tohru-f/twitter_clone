class RenameContentColumnToComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :content, :sentence
  end
end
