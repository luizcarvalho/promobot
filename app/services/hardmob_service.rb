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

  def update_promotions
    @promotions = fetch_promotion_links.map do |link|
      topic = Nokogiri.HTML5(open(link['href']))
      topic.css('li.postbitlegacy').each do |post|
        puts link['href']
        build_promotion(link, post)
        break
      end
    end
  end

  def build_promotion(link, post)
    @model.create(
      title: link.text,
      url: link['href'],
      text: '',
      resume: '',
      origin: 'hardmob',
      identifier: 1,
      promoter: post.css('.username').text
    )
  end


end
