class ZebraService < ApplicationService
  BASE_URL = 'https://www.zebraurbana.com.br'.freeze

  def initialize(model)
    @promotions = nil
    @model = model
  end

  def fetch_promotion_links
    html = Nokogiri::HTML(open(BASE_URL))
    html.css('a.product')
  end

  def fetch_promotion(link)
    promotion = Nokogiri.HTML5(open(link))
    promotion.css('.product').first
  end

  def fetch_lasts_promotions
    @promotions = fetch_promotion_links.map do |link|
      link_hash = convert_link(link)
      puts link_hash[:href]
      promotion = fetch_promotion(link_hash[:href])
      build_and_create_promotion(link_hash, promotion)
    end
  end

  def build_promotion(link, promotion)
    {
      title: extract_title(promotion),
      url: link[:href],
      text: format_promotion_content(promotion),
      origin: 'zebraurbana', promoter: 'zebraurbana',
      value: extract_value(promotion),
      image: extract_image(promotion),
      identifier: extract_identifier(link[:href]),
      relevance: extract_relevance(promotion)
    }
  end

  def build_and_create_promotion(link, promotion)
    create_promotion(build_promotion(link, promotion))
  end

  private

  def convert_link(link_node)
    { href: "#{BASE_URL}#{link_node['href']}", text: link_node.text }
  end

  def extract_title(promotion)
    promotion.css('header > h2').text.squeeze(' ').delete("\n")
  end

  def extract_image(promotion)
    partial_url = promotion.css('.carousel-inner > .item > img').first['src']
    "https:#{partial_url}"
  end

  def extract_relevance(promotion)
    promotion.css('p > span.text-danger').text&.to_i
  end

  def extract_value(promotion)
    promotion.css('.price > .new').text[/\d+,\d+/]
  end

  def format_promotion_content(promotion)
    promotion = promotion.css('.details').text
    promotion.delete!("\t")
    promotion.squeeze!(' ')
    promotion.squeeze!("\n")
    promotion
  end

  def extract_identifier(promotion_link)
    promotion_link[/\d+$/]
  end
end
