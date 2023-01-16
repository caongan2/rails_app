class CreateFollowes < ActiveRecord::Migration[7.0]
  def change
    create_table :followers do |t|
      t.integer :user_id
      t.integer :follower
      t.integer :followed, null: false, default: 0

      t.timestamps
    end
  end
end
