class SpendingPlanController < ApplicationController
  def new
    @spending_plan = SpendingPlan.new
  end

  def show
    @plan_issue = PlanIssue.find_by(id: params[:id])
  end

  def index
    @month = params[:month]
    @year = params[:year]
    @sum_expense = 0
    @spending_plans_count = 0
    if @month && @year
      if @month != '' && @year != ''
        @spending_plan = SpendingPlan.where(user_id: current_user.id, month: @month, year: @year).first
      else
        @spending_plan_year = SpendingPlan.where(user_id: current_user.id, year: @year)
        @spending_plan_year.each { |item| @sum_expense += item.max }
      end
    else
      @spending_plans = SpendingPlan.select("year, SUM(max) as max").group(:year).where(user_id: current_user.id)
      @spending_plans.each do |item|
        @sum_expense += item.max
        @spending_plans_count += 1
      end
    end

    if @spending_plan
      @plan_issue = PlanIssue.where(plan_id: @spending_plan.id)
      @plan_issue.each { |item| @sum_expense += item.expense }
    else
      @plan_issue = []
    end

  end

  def create
    @spending_plan = SpendingPlan.where(spending_plan_conditional).first

    if @spending_plan
      @max_value = (total(@spending_plan.id) + params[:fee][:expense].to_i) > @spending_plan.max
      if @max_value
        render json: {
          status: 0
        }
      else
        plan_issue_create(@spending_plan.id)
        render json: {
          status: 1
        }
      end
    else
      @spending_plan = SpendingPlan.new(spending_plan_data)
      if @spending_plan.save
        plan_issue_create(@spending_plan.id)
      end
      render json: {
        message: "Add spending plan successfully",
        status: 2
      }
    end
    # redirect_back(fallback_location: "")
  end

  def total (id)
    PlanIssue.where(plan_id: id).sum(:expense)
  end

  def plan_issue_create(id)
    @plan_issue = PlanIssue.new(plan_issue_data)
    @plan_issue.attributes = {plan_id: id}
    @plan_issue.save
  end

  def spending_plan_data
    params.require('item').permit(:user_id, :month, :year, :max)
  end

  def spending_plan_conditional
    params.require('item').permit(:user_id, :month, :year)
  end

  def plan_issue_data
    params.require('fee').permit(:issue, :expense)
  end
end
