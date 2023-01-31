class PdfsController < ApplicationController
  def show
    @plan = PlanIssue.find_by(id: 51)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@plan.issue}_#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}",
               template: "pdfs/show.html.erb",
               disposition: "attachment",
               layout: "pdf",
               orientation: "Landscape",
               encoding: "UTF-8"
      end
    end
  end

end
