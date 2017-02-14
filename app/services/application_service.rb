require 'nokogiri'
require 'open-uri'
class ApplicationService
  def create_promotion(promotion_params)
    Promotion.create(promotion_params)
  end

  def promotions_not_found(origin)
    puts "Nenhuma promoção encontrata para #{origin}"
  end
end
