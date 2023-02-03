class PlanIssue < ApplicationRecord
  belongs_to :spending_plan, foreign_key: :plan_id, optional: true
end
