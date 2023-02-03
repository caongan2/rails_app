class SpendingPlan < ApplicationRecord
  belongs_to :user
  has_many :plan_issues, dependent: :destroy, foreign_key: :plan_id

  accepts_nested_attributes_for :plan_issues
end
