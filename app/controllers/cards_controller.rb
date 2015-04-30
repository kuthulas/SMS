class CardsController < ApplicationController
  def index
    @cards = Card.all.paginate(:page => params[:page])
  end

  def import
    begin
       Card.import(params[:file])
       redirect_to cards_index_url, notice: "Cards imported."
    rescue
       redirect_to cards_index_url, notice: "Error in imported file!"
    end
  end
end
