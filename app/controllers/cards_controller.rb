class CardsController < ApplicationController
  def index
    if admin_signed_in?
      @filterrific = initialize_filterrific(
        Card,
        params[:filterrific],
        :select_options => {
          sorted_by: Card.options_for_sorted_by
        }
      ) or return
       @cards = @filterrific.find.page(params[:page])
    end
    respond_to do |format|
      format.html
      format.js
    end 
  end

   def destroy
    @card = Card.find(params[:id])
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
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
