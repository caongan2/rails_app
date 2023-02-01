class PdfsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf => "file.pdf", :template => 'pdfs/show',  formats: [:html]
      end
    end
  end

end
