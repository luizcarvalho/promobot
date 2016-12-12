require 'nokogiri'
require 'open-uri'
class ApplicationService
  def create_promotion(promotion_params)
    Promotion.create(promotion_params)
  end
end
