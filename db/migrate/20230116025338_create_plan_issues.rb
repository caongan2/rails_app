class CreatePlanIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_issues do |t|
      t.integer :plan_id
      t.string :issue
      t.integer :expense

      t.timestamps
    end
  end
end
