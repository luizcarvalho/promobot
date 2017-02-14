class PromotionBot
  def initialize
  end

  def search(term)
    return false if term.empty?
  end

  def search_and_format_for(term)
    promotions = Promotion.search(text_cont: term).result.limit(5)
    format_promotion_message(promotions)
  end

  def format_promotion_message(promotions)
    {
      'attachment': {
        'type': 'template',
        'payload': {
          'template_type': 'generic', elements: elements_generic(promotions)
        }
      }
    }
  end

  def elements_generic(promotions)
    promotions.map do |promotion|
      format_element_generic(promotion)
    end
  end

  def format_element_generic(promotion)
    {
      'title': promotion.title,
      'item_url': promotion.url,
      'image_url': promotion.image,
      'subtitle': promotion.resume,
      'buttons': [element_buttons(promotion)]
    }
  end

  def element_buttons(promotion)
    {
      'type': 'web_url',
      'url': promotion.url,
      'title': 'Ver no site'
    } 
  end
end
