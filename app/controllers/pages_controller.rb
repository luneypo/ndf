class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
  end

  def pdf
  end

  def csv
    arr_of_rows = "\\home\\eutech\\Bureau\\Projets\\rails_projects_tests\\ndf\\public\\export_csv\\export-compta-#{params[:id]}.csv"
    respond_to do |format|
      format.html
      format.csv { send_file arr_of_rows }
    end
  end

  def admin

  end
end
