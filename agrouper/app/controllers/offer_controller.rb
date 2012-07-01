class OfferController < ApplicationController
  def list
  	@offers = Offer.all
  end

end
