class TonolucroService < ApplicationService
  CORE_URL = 'https://www.tonolucro.com.br'.freeze
  BASE_URL = "#{CORE_URL}/palmas".freeze

  def initialize(model)
    @promotions = nil
    @model = model
  end

  def fetch_promotion_links
    html = Nokogiri::HTML(open(BASE_URL))
    html.css('.bl-extra-top-tit > a')
  end

  def fetch_promotion(link)
    promotion = Nokogiri.HTML5(open(link))
    promotion.css('.content-left-back').first
  end

  def build_promotion(link, promotion)
    basic_promotion_data(link, promotion).merge(origin: 'zebraurbana', promoter: 'zebraurbana')
  end

  def build_and_create_promotion(link, promotion)
    create_promotion(build_promotion(link, promotion))
  end

  private

  def convert_link(link_node)
    { href: "#{CORE_URL}#{link_node['href']}", text: link_node.text }
  end

  def extract_title(promotion)
    promotion.css('.oferta-titulo').text
  end

  def extract_image_url(promotion)
    promotion.css('.nivoSlider > img').first['src']
  end

  def extract_relevance(promotion)
    promotion.css('.quantidade').text
  end

  def extract_image(image_link)
    image_link = extract_image_url(image_link) unless image_link.is_a?(String)
    "#{CORE_URL}#{image_link}"
  end

  def extract_value(promotion)
    promotion.css('.vl').text
  end

  def format_promotion_content(promotion)
    promotion = promotion.css('.texto').text
    promotion.delete!("\t")
    promotion.gsub!('  ', ' ')
    promotion.gsub!("\n\n", "\n")
    promotion
  end

  def extract_identifier(promotion_link)
    promotion_link.match(%r{tonolucro.com.br\/(\d+)})[1]
  end
end
