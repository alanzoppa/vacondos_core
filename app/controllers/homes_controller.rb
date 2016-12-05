class HomesController < ApplicationController

  def index
    allowed = params.permit(:line1, :line2, :city, :state, :zip, :country)

    @homes = Home.joins(:lob_address, :coordinate)
    allowed.each do |key, value|
      @homes = @homes.where("address_#{key} LIKE ?", "#{value}%")
    end 

    respond_to do |format|
      format.json {
        render json: @homes.map {|h| h.confident_to_object}
      }
    end
  end
end
