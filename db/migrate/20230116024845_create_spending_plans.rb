class CreateSpendingPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :spending_plans do |t|
      t.integer :user_id
      t.integer :month
      t.integer :year
      t.integer :max

      t.timestamps
    end
  end
end
