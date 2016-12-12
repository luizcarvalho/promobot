class HardmobService < ApplicationService
  BASE_URL = 'http://www.hardmob.com.br/promocoes/'.freeze

  def initialize(model)
    @promotions = nil
    @model = model
  end

  def fetch_promotion_links
    html = Nokogiri::HTML(open(BASE_URL))
    html.css('#threads a.title')
  end

  def fetch_post(link)
    topic = Nokogiri.HTML5(open(link))
    topic.css('li.postbitlegacy').first
  end

  def fetch_lasts_promotions
    @promotions = fetch_promotion_links.map do |link|
      link = convert_link(link)
      puts link
      post = fetch_post(link[:href])
      build_and_create_promotion(link, post)
    end
  end

  def build_promotion(link, post)
    {
      title: link[:text],
      url: link[:href],
      text: format_post_content(post),
      origin: 'hardmob',
      value: extract_value(link[:text]),
      thumb: '', image: '',
      identifier: extract_identifier(link[:href]),
      promoter: post.css('.username').text
    }
  end

  def build_and_create_promotion(link, post)
    create_promotion(build_promotion(link, post))
  end

  private

  def convert_link(link_node)
    { href: link_node['href'], text: link_node.text }
  end

  # R$ 1 / R$ 1,00 / R$ 1.000,00 / R$ 1.000
  # R$1 /  R$1,00 / R$1.000,00 / R$1.000
  # $ 1 / $ 1,00 / $ 1.000,00 / $ 1.000
  # 1,00 100,00 1000,00
  def extract_value(link_text)
    link_text.scan(/R?\$\s*(\d*\d\.?\d*\,?\d{0,2})/)[1] || link_text.scan(/(\d*.?\d+,\d{0,2})/)[1]
  end

  def format_post_content(post)
    post = post.css('.postcontent').text
    post.delete!("\t")
    post.gsub!("\n\n", "\n")
    post
  end

  def extract_identifier(link_url)
    link_url.match(%r{promocoes\/(\d+)})[1]
  end
end
