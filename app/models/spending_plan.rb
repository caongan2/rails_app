class SpendingPlan < ApplicationRecord
  belongs_to :user
  has_many :plan_issues, dependent: :destroy
end
