class AddColumnPictureToPostsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :picture, :string, default: nil
  end
end
