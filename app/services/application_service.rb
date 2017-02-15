require 'nokogiri'
require 'open-uri'
class ApplicationService
  def create_promotion(promotion_params)
    Promotion.create(promotion_params)
  end

  def fetch_and_save_all
    promotions = fetch_promotion_links.map do |link|
      link_hash = convert_link(link)
      puts link_hash[:href]
      promotion = fetch_promotion(link_hash[:href])
      build_and_create_promotion(link_hash, promotion)
    end
    promotions_not_found(self.class.to_s) if promotions.empty?
  end

  def promotions_not_found(origin)
    puts "Nenhuma promoção encontrata para #{origin}"
  end
end
