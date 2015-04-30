class CardcontrollerController < ApplicationController
  def index
    @cards = Card.all.paginate(:page => params[:page])
  end

  def import
    begin
       Card.import(params[:file])
       redirect_to cardcontroller_index_url, notice: "Cards imported."
    rescue
       redirect_to cardcontroller_index_url, notice: "Error in imported file!"
    end
  end
end
