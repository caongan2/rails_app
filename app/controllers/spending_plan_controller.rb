class SpendingPlanController < ApplicationController
  def new
    @spending_plan = SpendingPlan.new
    @spending_plan.plan_issues.build
  end

  def edit
    @plan_issue = PlanIssue.find_by(id: params[:id])
  end

  def update
    @plan_issue = PlanIssue.find_by(params[:id])
    if @plan_issue.update(data_update)
      redirect_to action: "index"
    else
      redirect_back(fallback_location: "")
    end
  end

  def show
    @plan_issue = PlanIssue.find_by(id: params[:id])
    @spending_plan = SpendingPlan.find_by(id: @plan_issue.plan_id)
  end

  def export
    @plan_issue = PlanIssue.find_by(id: params[:id])
    @spending_plan = SpendingPlan.find_by(id: @plan_issue.plan_id)
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf => "#{@plan_issue.issue}_#{@plan_issue.created_at.strftime("%Y-%m-%d_%H-%M")}", :template => 'spending_plan/export',  formats: [:html]
      end
    end
  end

  def export_excel
    @plan_issues = PlanIssue.all
    respond_to do |format|
      format.html
      format.xls {
        filename = "Student-#{Time.now.strftime("%Y%m%d%H%M%S")}.xls"
        render :xls => filename, :template => 'spending_plan/export_excel',  formats: [:html], layout: false
      }
    end
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
    @spending_plan = spending_plan
    if @spending_plan
      if !spending_limit(@spending_plan.id)
        plan_issue_create(@spending_plan.id)
      else
        redirect_back(fallback_location: "")
      end
    else
      @spending_plan = current_user.spending_plans.new(spending_plan_data)
      if @spending_plan.save
        redirect_to action: "index"
      else
        render :new
      end
    end

    # render json: {
    #   message: "Add spending plan successfully",
    #   status: 2
    # }
    # @spending_plan = SpendingPlan.where(spending_plan_conditional).first
    #
    # if @spending_plan
    #   @max_value = (total(@spending_plan.id) + params[:fee][:expense].to_i) > @spending_plan.max
    #   if @max_value
    #     render json: {
    #       status: 0
    #     }
    #   else
    #     plan_issue_create(@spending_plan.id)
    #     render json: {
    #       status: 1
    #     }
    #   end
    # else
    #   @spending_plan = SpendingPlan.new(spending_plan_data)
    #   if @spending_plan.save
    #     # plan_issue_create(@spending_plan.id)
    #   end
    #   render json: {
    #     message: "Add spending plan successfully",
    #     status: 2
    #   }
    # end
    # redirect_back(fallback_location: "")
  end

  def spending_plan
    SpendingPlan.where(spending_plan_conditional).first
  end

  def spending_limit(id)
    @limit = SpendingPlan.find_by(id: id).max
    @current = PlanIssue.where(plan_id: id).sum(:expense)
    @new = params["spending_plan"]['plan_issues_attributes']["0"]["expense"]

    if @new.to_i + @current.to_i >= @limit.to_i
      return true
    end

    return false
  end

  def total (id)
    PlanIssue.where(plan_id: id).sum(:expense)
  end

  def plan_issue_create(id)
    @plan_issue = PlanIssue.new
    @plan_issue.attributes = {plan_id: id, issue: params["spending_plan"]['plan_issues_attributes']["0"]["issue"], expense: params["spending_plan"]['plan_issues_attributes']["0"]["expense"]}
    @plan_issue.save
    redirect_to action: "index"
  end

  def spending_plan_data
    params.require(:spending_plan).permit(:user_id, :month, :year, :max, plan_issues_attributes: [:id, :plan_id, :issue, :expense])
  end

  def spending_plan_conditional
    params.require(:spending_plan).permit(:user_id, :month, :year)
  end

  def plan_issue_data
    params.require(:spending_plan).permit(plan_issues_attributes: [:issue, :expense])
  end

  def data_update
    params.require(:plan_issue).permit(:issue, :expense)
  end
end
