class ApiController < ApplicationController
  def responder
    query = params[:result][:parameters]['promotion']
    if query.blank?
      response = failure_response
    else
      promotion_bot = PromotionBot.new
      fotmated_facebook_answer = promotion_bot.search_and_format_for(query)
      response = format_response(fotmated_facebook_answer)
    end

    render json: response
  end

  private

  def format_response(fotmated_facebook_answer)
    {
      "data": { "facebook": fotmated_facebook_answer },
      "source": 'PromoBot'
    }
  end

  def failure_response
    {
      "speech": 'Oops parece que não conseguimos procurar isso! =(',
      "displayText": 'Oops parece que não conseguimos procurar isso! =(',
      "data": '',
      "source": 'PromoBot'
    }
  end
end
